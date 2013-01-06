# encoding: UTF-8
class CategoriesController < ApplicationController
  def index
    @categories=Category.all
    @category=Category.new
  end
  def create
    if signed_in? && admin?
      @category=Category.new(params[:category])
      respond_to do |format|
        if @category.save
          format.js
        end
      end
    else
      flash[:error]="类别创建失败"
      redirect_to root_path
    end
  end
  def destroy
    @category=Category.find(params[:id])
    @category.destroy
    respond_to do |format|
      format.js
    end
  end
end
