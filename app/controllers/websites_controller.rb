class WebsitesController < ApplicationController
  def index
    @websites = Website.all
  end
  def show
    @website = Website.find(params[:id])
  end
  def new
    @website = Website.new
    @website.categories_selectors.build
    @website.list_selectors.build
    @website.content_selectors.build
    @website.remove_selectors.build
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
      categories_selectors_attributes: [:id,:selector,:selector_type,:_destroy],
      list_selectors_attributes: [:id,:selector,:selector_type,:_destroy],
      content_selectors_attributes: [:id,:selector,:selector_type,:_destroy],
      remove_selectors_attributes: [:id,:selector,:selector_page,:_destroy]
      )
  end

end