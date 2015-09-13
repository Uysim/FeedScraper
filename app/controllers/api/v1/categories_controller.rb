class Api::V1::CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
  end
end