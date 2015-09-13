class Api::V1::ContentsController < ApplicationController
  def show
    @content = Content.find(params[:id])
  end
end