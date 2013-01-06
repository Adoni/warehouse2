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

  def allitem
    if signed_in? && admin?
      @items = Array.new
      Category.all.each do |c|
        i = {'category'=>c.name, 'items'=>[]}
        c.items.each do |item|
          if item.amount==0
            next
          end
          already=false 
          i['items'].each do |h|
            if h['name'].eql?(item.name) && h['spec'].eql?(item.spec) && h['unit'].eql?(item.unit) && h['price']==item.price
              already=true
              break
            end
          end
          if !already
            j = {'id'=>item.id, 'name'=>item.name, 'spec'=>item.spec, 'unit'=>item.unit, 'price'=>item.price}
            i['items']<<j
          end
        end
        @items<<i
      end 

      render 'allitem'
    else
      flash[:error]="没有权限"
      redirect_to root_path
    end
  end
end
