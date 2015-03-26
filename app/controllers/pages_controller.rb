class PagesController < ApplicationController
  def show
    @page = params[:id]
    raise "Invalid page: #{@page.inspect}" unless File.exist?(Rails.root.join("app/views/pages/_#{@page}.html.slim"))
  end
end
