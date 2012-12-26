# encoding: UTF-8
class EachHousesController < ApplicationController
  def create
    @newhouse=EachHouse.new(params[:each_house])
    print @newhouse.name 
    if signed_in? && admin?
      if @newhouse.save
        flash[:success]="添加库房成功"
        redirect_to each_houses_path
      else
        flash[:error]="添加库房失败"
        @eachhouses=EachHouse.all
        render 'index'
      end
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end

  def index
    if signed_in? && admin?
      @newhouse=EachHouse.new
      @eachhouses=EachHouse.all
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end

  def destroy
  end
  
  def show
    @eachhouses=EachHouse.all
    @newhouse=EachHouse.new
  end
end
