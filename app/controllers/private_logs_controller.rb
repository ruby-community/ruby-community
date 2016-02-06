class PrivateLogsController < LogsController
  before_action :authenticate_user!

  DefaultChannel  = "#ruby-ops".freeze
  AllowedChannels = %w[#ruby-ops #ruby-banned #ruby #ruby-community #ruby-offtopic].to_set
  Attributes      = %w[topic].to_set
end
