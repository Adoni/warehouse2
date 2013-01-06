# encoding: UTF-8
class MainListsController < ApplicationController
  def index
    create
  end
  def create
    if signed_in? && admin?
      if !session[:main_list_in].nil?
        @main_list=MainList.find(session[:main_list_in])
        @item=Item.new
        @items=@main_list.items
        render 'newin'
      elsif !session[:main_list_out].nil?
        @main_list=MainList.find(session[:main_list_out])
        @item=Item.new
        @items=@main_list.items
        render 'newout'
      else
        @main_list=MainList.new(params[:main_list])
        @item =Item.new
        @items=@main_list.items
        if @main_list.save
          if @main_list.source.nil?
            session[:main_list_in]=@main_list.id
            render 'newin'
          else
            session[:main_list_out]=@main_list.id
            render 'newout'
          end
        else
          flash[:error]="错误"
          redirect_to operate_path
        end
      end
    else
      flash[:warning]="没有权限"
      redirect_to root_path
    end
  end
  def destroy
    @main_list = MainList.find(params[:id])
    if @main_list.source.nil?
      session[:main_list_in]=nil
      if @main_list.destroy
        flash[:success]="入库单删除成功"
      else
        flash[:error]="入库单删除失败"
      end
    else
      session[:main_list_out]=nil
      if @main_list.destroy
        flash[:success]="出库单删除成功"
      else
        flash[:error]="出库单删除失败"
      end
    end
    redirect_to operate_path
  end

  def update
    if !session[:main_list_in].nil?
      @main_list=MainList.find(session[:main_list_in])
      session[:main_list_in]=nil
      render 'print_list_in'
    else
      @main_list=MainList.find(session[:main_list_out])
      session[:main_list_out]=nil
      render 'print_list_out'
    end
  end
end
