class PrivatePagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @page = params[:id]
    raise "Invalid page: #{@page.inspect}" unless File.exist?(Rails.root.join("app/views/private_pages/_#{@page}.html.slim"))
  end
end
