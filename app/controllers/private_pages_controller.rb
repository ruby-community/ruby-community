class PrivatePagesController < ApplicationController
  before_action :authenticate_user!
  helper_method :ban_group_status

  def show
    @page = params[:id]
    raise "Invalid page: #{@page.inspect}" unless File.exist?(Rails.root.join("app/views/private_pages/_#{@page}.html.slim"))
  end

  def bans
    @channels = Ban.group(:channel).order(:channel).pluck(:channel, Arel.sql('count(distinct bangroup_id)'))
    render :channels
  end

  def channel_bans
    @channel = '#' + params[:channel]
    @bans = Ban.where(channel: @channel)
               .order(:bangroup_id)
               .reverse_order
               .order(:banned_at, :id)
               .all
               .group_by(&:bangroup_id)
    render :bans
  end

  BAN_STATUS_STYLE = {
    active:  'success',
    partial: 'info',
    mixed:   'warning',
    deleted: 'danger',
    expired: 'warning'
  }.freeze

  BAN_STATUS_ICONS = {
    active:           %w[success circle],
    suspended:        %w[success dot-circle-o],
    deleted:          %w[danger circle],
    manually_deleted: %w[danger minus-circle],
    expired:          %w[warning clock-o]
  }.freeze

  private

  def ban_group_status(group)
    if group.all?(&:ban_active?)
      :active
    elsif group.any?(&:ban_active?)
      :partial
    elsif group.all? { |ban| group.first.status == ban.status }
      group.first.status == 'manually_deleted' ? :deleted : group.first.status.to_sym
    else
      :mixed
    end
  end
end
