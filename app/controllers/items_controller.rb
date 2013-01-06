# encoding: UTF-8
class ItemsController < ApplicationController
  def create
    if !session[:main_list_in].nil?
      @main_list=MainList.find(session[:main_list_in])
    end  
    @item=@main_list.items.build(params[:item])
    respond_to do |format|
      if @item.save
        @main_list.total_amount += @item.amount
        @main_list.total_price += @item.price*@item.amount
        @main_list.update_column(:total_amount, @main_list.total_amount)
        @main_list.update_column(:total_price, @main_list.total_price)
        format.js
      end
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    
    if !session[:main_list_in].nil?
      @main_list=MainList.find(@item.main_list_id)
      @main_list.total_amount -= @item.amount
      @main_list.total_price -= @item.price*@item.amount
      @main_list.update_column(:total_amount, @main_list.total_amount)
      @main_list.update_column(:total_price, @main_list.total_price)
    else
      @main_list=MainList.find(@item.main_list_id)
      @main_list.total_amount -= @item.amount
      @main_list.total_price -= @item.price*@item.amount
      @main_list.update_column(:total_amount, @main_list.total_amount)
      @main_list.update_column(:total_price, @main_list.total_price)
      
      @sourceHouse = EachHouse.find(@main_list.source)
      @sourceHouse.items.each do |a|
        if a.name.eql?(@item.name) && a.spec.eql?(@item.spec) && a.unit.eql?(@item.unit) && a.price==@item.price
          a.amount += @item.amount
          a.update_column(:amount, a.amount)
          break
        end
      end
    end

    @item.destroy
    respond_to do |format|
      format.js
    end
  end
  def edit
    @item=Item.find(params[:id])
  end

  def update
    if signed_in? && admin?
      @sourceItem=Item.find(params[:id])
      @destItem=Item.new(params[:item])
      if @sourceItem.amount<@destItem.amount
        flash[:error]="调拨数量大于库存数量"
        redirect_to operate_path
      else
        @sourceItem.amount -= @destItem.amount
        @sourceItem.update_column(:amount, @sourceItem.amount)
        if @destItem.save
          @main_list=MainList.find(session[:main_list_out])
          @main_list.total_amount += @destItem.amount
          @main_list.total_price += @destItem.price*@destItem.amount
          @main_list.update_column(:total_amount, @main_list.total_amount)
          @main_list.update_column(:total_price, @main_list.total_price)
          redirect_to main_lists_path
        end
      end
    elsif signed_in?
      @item=Item.find(params[:id])
      @out_amount=params[:item][:amount].to_i
      if @out_amount>@item.amount
        flash[:error]="出库数量大于库存数量"
        redirect_to operate_path
      end
      @item.amount -= @out_amount
      @item.update_column(:amount, @item.amount)
      flash[:success]="出库成功"
      redirect_to operate_path
    else
    end
  end
end
