class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end
  def show
    @website = Website.find(params[:id])
  end
end