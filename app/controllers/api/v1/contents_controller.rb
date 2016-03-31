class Api::V1::ContentsController < ApplicationController
  def show
    @content = Content.find(params[:id])
    # content = JSON.parse(File.read('public/json_file/contents/1.json'))
    # render json: content
  end
end
