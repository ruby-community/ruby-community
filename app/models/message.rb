class Message < ActiveRecord::Base
  def self.topic(channel, at=Time.zone.now)
    message = where(channel: channel, topic: topic, command: "332".freeze).where("time > ?".freeze, at).order(:time).last

    message.body
  end

  def self.for_json
    select(:id, "round(extract(epoch from time)*1000) as json_time".freeze, :channel, :from_account, :from_nick, :from_username, :from_host, :command, :body)
  end

  def full_identifier
    %{#{from_account ? "$a:#{from_account}" : "$~a".freeze} #{from_nick}!#{from_username}@#{from_account}}
  end

  def formatted_date
    time.utc.strftime("%Y-%m-%d %H:%M:%SZ".freeze)
  end

  def formatted_time
    time.utc.strftime("%H:%M".freeze)
  end
end
