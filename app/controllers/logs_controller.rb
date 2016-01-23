require "set"
require "time"
require "date"

class LogsController < ApplicationController
  helper :log

  DefaultChannel  = "#ruby".freeze
  PublicChannels  = %w[#ruby #ruby-community #ruby-offtopic].to_set
  PrivateChannels = (%w[#ruby-ops #ruby-banned]+PublicChannels.to_a).to_set
  Attributes      = %w[topic].to_set

  def index
    channel = channel_param

    respond_to do |format|
      format.json do
        json_data = Message.where(
          command: ["PRIVMSG".freeze, "JOIN".freeze, "PART".freeze, "QUIT".freeze, "NICK".freeze],
          channel: channel,
          time:    from_param..to_param
        ).for_json.order(:time).last(2500).map { |message|
          message.as_json
        }

        render json: json_data
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        case attribute_param
          when "topic".freeze then "TODO"
          else raise "unreachable"
        end
      end
    end
  end

private
  def channel_param
    channel = params[:channel].presence || DefaultChannel
    raise "Illegal channel: #{channel}" unless PublicChannels.include?(channel)

    channel
  end

  def attribute_param
    id = params[:id]
    raise "Illegal id #{id}" unless Attributes.include?(id)

    id
  end

  def from_param
    @_from_param ||= begin
      if params[:from].present?
        DateTime.iso8601(params[:from]).in_time_zone
      else
        1.day.ago
      end
    end
  end

  def to_param
    @_to_param ||= begin
      if params[:to].present?
        DateTime.iso8601(params[:to]).in_time_zone
      else
        from_param + 1.day
      end
    end
  end

  def param_to_time(value)
  end
end
