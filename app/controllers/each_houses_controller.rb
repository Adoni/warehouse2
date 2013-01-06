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

  def update
    if signed_in? && admin?
      @house=EachHouse.find(params[:id])
      if !@house.user_id.nil?
        @olduser=User.find(@house.user_id)
      end
      
      @newuser=User.find(params[:each_house][:user_id])
      if @house.update_attributes(params[:each_house])
        if !@olduser.nil?
          @olduser.update_column(:each_house_id, nil)
        end
        if !@newuser.each_house_id.nil?
          EachHouse.find(@newuser.each_house_id).update_column(:user_id, nil)
        end
        @house.update_column(:user_id, @newuser.id)
        @newuser.update_column(:each_house_id, @house.id)
        flash[:success]="更新仓库资料成功"
      else
        flash[:error]="更新仓库资料失败"
      end
      redirect_to @house
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end

  def index
    if signed_in? && admin?
      @newhouse=EachHouse.new
      @eachhouses=EachHouse.all
    elsif signed_in?
      @eachhouse=EachHouse.find(current_user.each_house_id)
      render 'show'
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end

  def destroy
    if signed_in? && admin?
      @house=EachHouse.find(params[:id])
      if @house.destroy
        if !@house.user_id.nil?
          User.find(@house.user_id).update_column(:each_house_id, nil)
        end
        flash[:success]="删除仓库成功"
        redirect_to each_houses_path
      else
        flash[:success]="删除仓库失败"
        redirect_to @house
      end
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end
  
  def show
    if signed_in? && admin?
      @eachhouse=EachHouse.find(params[:id])
      @eachhouses=EachHouse.all
      @newhouse=EachHouse.new
    else
      flash[:warning]="没有权限"
    end
  end
end
