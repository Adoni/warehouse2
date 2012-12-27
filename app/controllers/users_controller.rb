# encoding: UTF-8
class UsersController < ApplicationController
  def index
    @users=User.all
  end
  
  def destroy
    if signed_in? && admin?
      @user=User.find(params[:id])
      if @user.destroy
        if !@user.each_house_id.nil?
          EachHouse.find(@user.each_house_id).update_column(:user_id, nil)
        end
        flash[:success]="删除成功"
      else
        flash[:error]="删除失败"
      end
    else
      flash[:error]="没有权限"
    end
    redirect_to users_path
  end

  def edit
    @user=current_user
  end

  def update
    @user=current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "更新密码成功"
      sign_in @user
      redirect_to root_path
    else
      flash[:error] = "更新密码失败"
      render 'edit'
    end
  end

  def create
    if signed_in? && admin?
      @user=User.new(params[:user])
      if @user.save
        if !@user.each_house_id.nil?
          EachHouse.find(@user.each_house_id).update_column(:user_id, @user.id)
        end
        flash[:success]="添加成功"
        redirect_to root_path
      else
        flash[:error]="添加失败"
        @dormitory=Array.new
        render 'new'
      end
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end

  def newUser
    if signed_in? && admin?
      @dormitory = Array.new
      EachHouse.where("user_id IS NULL").order("name DESC").all.each do |f|
        a=[f.name, f.id]
        @dormitory<<a
      end
      @user = User.new
      @user.admin=0
      @user.type_desc="楼长"
      render 'new'
    else
      flash[:warning] = "对不起，您没有权限"
      redirect_to root_path
    end
  end

  def newAdmin
    if signed_in? && admin?
      @dormitory = Array.new
      EachHouse.where("user_id IS NULL").order("name DESC").all.each do |f|
        a=[f.name, f.id]
        @dormitory<<a
      end
      @user = User.new
      @user.admin=1
      @user.type_desc="管理员"
      render 'new'
    else
      flash[:warning] = "对不起，您没有权限"
      redirect_to root_path
    end
  end
end
