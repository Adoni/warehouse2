# encoding: UTF-8
class StaticpagesController < ApplicationController
  def home
  end
  def operate
    if signed_in? && admin?
      @main_list=MainList.new
      @dormitory=Array.new
      EachHouse.order("name DESC").all.each do |f|
        a=[f.name, f.id]
        @dormitory<<a
      end
      render 'adminOperate'
    elsif signed_in?
      render 'floorOperate'
    else
      flash[:error]="没有权限"
      redirect_to root_path
    end
  end
  def outhouse
    if signed_in?
      @eachhouse=EachHouse.find(current_user.each_house_id)
    else
      redirect_to root_path
    end
  end
  def exwarehouse
  end
end
