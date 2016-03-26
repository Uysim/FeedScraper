class Api::V1::WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end
  def show
    # @website = Website.find(params[:id])
    website = JSON.parse(File.read("public/json_file/websites/1.json"))
    render json: website
  end
  def new
    @website = Website.new
    # @website.selectors.build
  end

  def create
    @website = Website.create(website_params)
    if @website.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @website = Website.find(params[:id])
  end

  def update
    @website = Website.find(params[:id])
    if @website.update(website_params)
      redirect_to root_path
    else
      render :edit
    end

  end

  private
  def website_params
    params.require(:website).permit(:name,:link_url,
      selectors_attributes: [:id,:selector,:selector_type,:_destroy],
      remove_selectors_attributes: [:id,:selector,:selector_page,:_destroy]
      )
  end

end