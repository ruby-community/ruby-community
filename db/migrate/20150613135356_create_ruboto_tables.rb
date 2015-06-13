class CreateRubotoTables < ActiveRecord::Migration
  def change
    create_table :ruboto_tables do |t|
      execute <<-SQL
        CREATE TABLE messages (
          "id"                serial PRIMARY KEY NOT NULL,
          "dialog_id"         bigint,
          "time"              timestamp with time zone NOT NULL,
          "source"            smallint NOT NULL,
          "raw"               bytea NOT NULL,
          "sanitized"         text,
          "html"              text,
          "json"              jsonb,
          "command"           varchar(32),
          "body"              text,
          "channel"           varchar(32),
          "from_nick"         varchar(32),
          "from_account"      varchar(32),
          "from_mask"         varchar(255),
          "to_nick"           varchar(32),
          "to_account"        varchar(32),
          "to_mask"           varchar(255),
          "nicks"             varchar(32)[],
          "accounts"          varchar(32)[]
        )
      SQL

      <<-SQL.strip.each_line do |line| execute(line.chomp(";")) end
        COMMENT ON TABLE  messages                   IS 'A log of all messages in the logged channels. Each record is one message.';
        COMMENT ON COLUMN messages.id                IS 'Primary key.';
        COMMENT ON COLUMN messages.dialog_id         IS 'Foreign key to dialogs - used to connect messages which form a dialog.';
        COMMENT ON COLUMN messages.time              IS 'Time at which the message was sent.';
        COMMENT ON COLUMN messages.source            IS 'Code of the source, defines how raw needs to be parsed. 1 = raw irc message, 2 = whitequarks log.';
        COMMENT ON COLUMN messages.raw               IS 'Unprocessed message.';
        COMMENT ON COLUMN messages.sanitized         IS 'The message in utf-8, with invalid data sanitized or removed.';
        COMMENT ON COLUMN messages.html              IS 'Processed message, rendered as html, ready for website display.';
        COMMENT ON COLUMN messages.json              IS 'Processed message, rendered as json, ready for API consumption.';
        COMMENT ON COLUMN messages.command           IS 'The type of message, values: join, part, quit, kick, kline, nick, topic, ban, unban, mode, message, notice';
        COMMENT ON COLUMN messages.body              IS 'The message body, depends on type. Usually the part of a message which humans read.';
        COMMENT ON COLUMN messages.from_nick         IS 'The senders nick.';
        COMMENT ON COLUMN messages.from_account      IS 'The senders account, if applicable.';
        COMMENT ON COLUMN messages.from_mask         IS 'The senders full mask.';
        COMMENT ON COLUMN messages.to_nick           IS 'The meaning depends on the message type - the nick of the receiver or target of a message/kick/ban.';
        COMMENT ON COLUMN messages.to_account        IS 'The meaning depends on the message type - the account of the receiver or target of a message/kick/ban.';
        COMMENT ON COLUMN messages.to_mask           IS 'The meaning depends on the message type - the mask of the receiver or target of a message/kick/ban.';
        COMMENT ON COLUMN messages.nicks             IS 'All recognized nicks occuring in the message.';
        COMMENT ON COLUMN messages.accounts          IS 'All recognized accounts occuring in the message.';
      SQL

      execute <<-SQL
        CREATE TABLE facts (
          "id"                serial PRIMARY KEY NOT NULL,
          "target_fact_id"    integer REFERENCES facts (id) ON DELETE CASCADE,
          "name"              text,
          "text"              text,
          "usage_count"       integer DEFAULT 0,
          "added_by_mask"     varchar(32),
          "added_by_account"  varchar(255),
          "updated_at"        timestamp with time zone
        )
      SQL

      execute <<-SQL
        CREATE OR REPLACE VIEW resolved_facts AS
          WITH RECURSIVE target(target_id) AS (
              SELECT "id",
                     "name",
                     "text",
                     "added_by_mask",
                     "added_by_account",
                     "updated_at",
                     false AS "is_alias",
                     "id" AS "root_fact_id",
                     "name" AS "root_fact_name"
              FROM facts WHERE facts."target_fact_id" IS NULL
            UNION
              SELECT facts."id",
                     facts."name",
                     target."text",
                     facts."added_by_mask",
                     facts."added_by_account",
                     facts."updated_at",
                     true AS "is_alias",
                     target."root_fact_id",
                     target."root_fact_name"
              FROM facts JOIN target ON facts."target_fact_id" = target_id
          )
          SELECT "target_id" AS "id",
                 "name",
                 "text",
                 "added_by_mask",
                 "added_by_account",
                 "updated_at",
                 "is_alias",
                 "root_fact_id",
                 "root_fact_name"
          FROM target
      SQL

      execute <<-SQL
        CREATE TABLE paste_service_offenders (
          "id"           serial PRIMARY KEY NOT NULL,
          "nick"         varchar(32),
          "mask"         varchar(32),
          "account"      varchar(255),
          "service"      text,
          "last_used_at" timestamp with time zone
        )
      SQL
    end
  end
end
