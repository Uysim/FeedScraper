class Api::V1::CategoriesController < ApplicationController
  def show
    # @category = Category.find(params[:id])
    if params[:page].to_i==0
      category = JSON.parse(File.read('public/json_file/categories/1.json'))
      render json: category
    else
      category = {
        name: "Apple",
        website: {
          id: 1,
          name: "CNET",
        },
        contents: []
      }
      render json: category
    end
  end
end