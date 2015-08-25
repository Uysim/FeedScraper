class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end
  def show
    @website = Website.find(params[:id])
  end
  def new
    @website = Website.new
    @website.selectors.build
  end

  def create

  end
end