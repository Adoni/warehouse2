# encoding: UTF-8
class StaticpagesController < ApplicationController
  attr_accessor :items
  attr_accessor :category, :dormitory
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

  def queryin
    @items = Array.new
    @t = Time.new
    @year = @t.strftime("%Y")
    @month = @t.strftime("%m")
    @day = @t.strftime("%d")
  end
  def doqueryin
    @startyear = params[:startDate][0,4].to_i
    @startmonth = params[:startDate][5,6].to_i
    @startday = params[:startDate][8,9].to_i
    @endyear = params[:endDate][0,4].to_i
    @endmonth = params[:endDate][5,6].to_i
    @endday = params[:endDate][8,9].to_i
    @warehouse = params[:warehouse][0]
    @AorB = {"A"=>1, "B"=>2}

    @list=Array.new
    MainList.all.each do |each_main_list|
      @yearOfEachItem = each_main_list.updated_at.strftime("%Y").to_i
      @monthOfEachItem = each_main_list.updated_at.strftime("%m").to_i
      @dayOfEachItem = each_main_list.updated_at.strftime("%d").to_i
      if @startyear<@yearOfEachItem && @yearOfEachItem<@endyear
        #putin
        if each_main_list.source.nil? && each_main_list.destination==@AorB[@warehouse]
          @list<<each_main_list
        end
      elsif @startyear==@yearOfEachItem && @yearOfEachItem<@endyear
        if @startmonth<@monthOfEachItem
          #putin
          if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
            @list<<each_main_list
          end
        elsif @startmonth==@monthOfEachItem
          if @startday <= @dayOfEachItem
            #putin
            if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
              @list<<each_main_list
            end
          end
        end
      elsif @startyear<@yearOfEachItem && @yearOfEachItem==@endyear
        if @monthOfEachItem<@endmonth
          #putin
          if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
            @list<<each_main_list
          end
        elsif @monthOfEachItem==@endmonth
          if @dayOfEachItem<=@endday
            #putin
            if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
              @list<<each_main_list
            end
          end
        end
      elsif @startyear==@yearOfEachItem && @yearOfEachItem==@endyear
        if @startmonth<@monthOfEachItem && @monthOfEachItem<@endmonth
          #putin
          if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
            @list<<each_main_list
          end
        elsif @startmonth==@monthOfEachItem && @monthOfEachItem<@endmonth
          if @startday <= @dayOfEachItem
            #putin
            if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
              @list<<each_main_list
            end
          end
        elsif @startmonth<@monthOfEachItem && @monthOfEachItem==@endmonth
          if @dayOfEachItem <= @endday
            #putin
            if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
              @list<<each_main_list
            end
          end
        elsif @startmonth==@monthOfEachItem && @monthOfEachItem==@endmonth
          if @startday<=@dayOfEachItem && @dayOfEachItem<=@endday
            #putin
            if each_main_list.source.nil?&& each_main_list.destination==@AorB[@warehouse]
              @list<<each_main_list
            end
          end
        end
      end
    end
  end
  def queryout
    @house=EachHouse.all
    @items = Array.new
    @t = Time.new
    @year = @t.strftime("%Y")
    @month = @t.strftime("%m")
    @day = @t.strftime("%d")
  end
  def doqueryout
    @startyear = params[:startDate][0,4].to_i
    @startmonth = params[:startDate][5,6].to_i
    @startday = params[:startDate][8,9].to_i
    @endyear = params[:endDate][0,4].to_i
    @endmonth = params[:endDate][5,6].to_i
    @endday = params[:endDate][8,9].to_i
    @warehouse = params[:warehouse].to_i
    @list=Array.new
    MainList.all.each do |each_main_list|
      @yearOfEachItem = each_main_list.updated_at.strftime("%Y").to_i
      @monthOfEachItem = each_main_list.updated_at.strftime("%m").to_i
      @dayOfEachItem = each_main_list.updated_at.strftime("%d").to_i
      if @startyear<@yearOfEachItem && @yearOfEachItem<@endyear
        #putout
        if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
          @list<<each_main_list
        end
      elsif @startyear==@yearOfEachItem && @yearOfEachItem<@endyear
        if @startmonth<@monthOfEachItem
          #putin
          if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
            @list<<each_main_list
          end
        elsif @startmonth==@monthOfEachItem
          if @startday <= @dayOfEachItem
            #putin
            if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
              @list<<each_main_list
            end
          end
        end
      elsif @startyear<@yearOfEachItem && @yearOfEachItem==@endyear
        if @monthOfEachItem<@endmonth
          #putin
          if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
            @list<<each_main_list
          end
        elsif @monthOfEachItem==@endmonth
          if @dayOfEachItem<=@endday
            #putin
            if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
              @list<<each_main_list
            end
          end
        end
      elsif @startyear==@yearOfEachItem && @yearOfEachItem==@endyear
        if @startmonth<@monthOfEachItem && @monthOfEachItem<@endmonth
          #putin
          if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
            @list<<each_main_list
          end
        elsif @startmonth==@monthOfEachItem && @monthOfEachItem<@endmonth
          if @startday <= @dayOfEachItem
            #putin
            if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
              @list<<each_main_list
            end
          end
        elsif @startmonth<@monthOfEachItem && @monthOfEachItem==@endmonth
          if @dayOfEachItem <= @endday
            #putin
            if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
              @list<<each_main_list
            end
          end
        elsif @startmonth==@monthOfEachItem && @monthOfEachItem==@endmonth
          if @startday<=@dayOfEachItem && @dayOfEachItem<=@endday
            #putin
            if (!each_main_list.source.nil?) && (each_main_list.source==@warehouse || each_main_list.destination==@warehouse)
              @list<<each_main_list
            end
          end
        end
      end
    end
  end

  def statistics
    @items = Array.new
    @t = Time.new
    @year = @t.strftime("%Y")
    @month = @t.strftime("%m")
    @day = @t.strftime("%d")
  end

  def dostatistic
    @t = Time.new
    @year = @t.strftime("%Y")
    @month = @t.strftime("%m")
    @day = @t.strftime("%d")
    @startyear = params[:startDate][0,4].to_i
    @startmonth = params[:startDate][5,6].to_i
    @startday = params[:startDate][8,9].to_i
    @endyear = params[:endDate][0,4].to_i
    @endmonth = params[:endDate][5,6].to_i
    @endday = params[:endDate][8,9].to_i
    @warehouse = params[:warehouse][0]
    @AorB = {"A"=>1, "B"=>2}
    @main_lists = MainList.all
    @items = Array.new
    @main_lists.each do |each_main_list|
      @yearOfEachItem = each_main_list.updated_at.strftime("%Y").to_i
      @monthOfEachItem = each_main_list.updated_at.strftime("%m").to_i
      @dayOfEachItem = each_main_list.updated_at.strftime("%d").to_i
      if @startyear<@yearOfEachItem && @yearOfEachItem<@endyear
        query(each_main_list)
      elsif @startyear==@yearOfEachItem && @yearOfEachItem<@endyear
        if @startmonth<@monthOfEachItem
          query(each_main_list)
        elsif @startmonth==@monthOfEachItem
          if @startday <= @dayOfEachItem
            query(each_main_list)
          end
        end
      elsif @startyear<@yearOfEachItem && @yearOfEachItem==@endyear
        if @monthOfEachItem<@endmonth
          query(each_main_list)
        elsif @monthOfEachItem==@endmonth
          if @dayOfEachItem<=@endday
            query(each_main_list)
          end
        end
      elsif @startyear==@yearOfEachItem && @yearOfEachItem==@endyear
        if @startmonth<@monthOfEachItem && @monthOfEachItem<@endmonth
          query(each_main_list)
        elsif @startmonth==@monthOfEachItem && @monthOfEachItem<@endmonth
          if @startday <= @dayOfEachItem
            query(each_main_list)
          end
        elsif @startmonth<@monthOfEachItem && @monthOfEachItem==@endmonth
          if @dayOfEachItem <= @endday
            query(each_main_list)
          end
        elsif @startmonth==@monthOfEachItem && @monthOfEachItem==@endmonth
          if @startday<=@dayOfEachItem && @dayOfEachItem<=@endday
            query(each_main_list)
          end
        end
      end
    end
    @items.each do |h|
      EachHouse.find(@AorB[@warehouse]).items.each do |i|
        if h['name'].eql?(i.name) && h['spec'].eql?(i.spec) && h['unit'].eql?(i.unit) && h['price']==i.price
          h['end_amount']+=i.amount
        end
      end
      h['begin_amount']=h['end_amount']-h['in_amount']+h['out_amount']
      h['begin_price']=h['price']*h['begin_amount']
      h['end_price']=h['price']*h['end_amount']
      h['in_price']=h['price']*h['in_amount']
      h['out_price']=h['price']*h['out_amount']
    end
  end
 
  def query(main_list)
    #items [{'name'=>   'spec'=>  'unit'=>  'price'=>  'begin_amount'=> 'begin_price'=> 'in_amount'=> 'in_price'=> 'out_amount'=> 'out_price'=> 'end_amount'=> 'end_price'=> }]
    if main_list.source.nil? && main_list.destination==@AorB[@warehouse]#入库单
      main_list.items.each do |i|
        already=false
        @items.each do |h|
          if h['name'].eql?(i.name) && h['spec'].eql?(i.spec) && h['unit'].eql?(i.unit) && h['price']==i.price
            h['in_amount']+=i.in_amount
            already=true
            break
          end
        end
        if !already
          j={'name'=>i.name, 'spec'=>i.spec, 'unit'=>i.unit, 'price'=>i.price, 'begin_amount'=>0, 'begin_price'=>0.00, 'in_amount'=>0, 'in_price'=>0.00, 'out_amount'=>0, 'out_price'=>0.00, 'end_amount'=>0, 'end_price'=>0.00 }
          j['in_amount']=i.in_amount
          @items<<j
        end
      end
    elsif main_list.source==@AorB[@warehouse]#出库单
      main_list.items.each do |i|
        already=false
        @items.each do |h|
          if h['name'].eql?(i.name) && h['spec'].eql?(i.spec) && h['unit'].eql?(i.unit) && h['price']==i.price
            already=true
            h['out_amount']+=i.out_amount
            break
          end
        end
        if !already
          j={'name'=>i.name, 'spec'=>i.spec, 'unit'=>i.unit, 'price'=>i.price, 'begin_amount'=>0, 'begin_price'=>0.00, 'in_amount'=>0, 'in_price'=>0.00, 'out_amount'=>0, 'out_price'=>0.00, 'end_amount'=>0, 'end_price'=>0.00 }
          j['out_amount']=i.out_amount
          @items<<j
        end
      end
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

  def report
    @t = Time.new
    @year = @t.strftime("%Y")
    @month = @t.strftime("%m")
    @day = @t.strftime("%d")
  end

  def doreport
    @category = Array.new
    #category{"id"=>, "thismonth"=>, "lastmonth"=>, "in"=>, "out"=>}
    @startyear = params[:startDate][0,4].to_i
    @startmonth = params[:startDate][5,6].to_i
    @warehouse = params[:warehouse][0]
    @AorB = {"A"=>1, "B"=>2}

    Category.all.each do |c|
      newcat={"thismonth"=>0, "lastmonth"=>0, "in"=>0, "out"=>0}
      newcat['id']=c.id

      c.items.each do |i|
        if i.each_house_id==@AorB[@warehouse]
          newcat['thismonth'] += i.amount*i.price
        end 
      end
      @category<<newcat
    end

    MainList.all.each do |m|
      @yearOfEachItem = m.updated_at.strftime("%Y").to_i
      @monthOfEachItem = m.updated_at.strftime("%m").to_i
      if @yearOfEachItem==@startyear && @monthOfEachItem==@startmonth
        if m.source==@AorB[@warehouse]#出库单
          m.items.each do |i|
            @category.each do |c|
              if c['id']==i.category_id
                c['out']+=i.out_amount*i.price
              end
            end
          end
        end
        if m.source.nil? && m.destination==@AorB[@warehouse]#入库单
          m.items.each do |i|
            @category.each do |c|
              if c['id']==i.category_id
                c['in']+=i.in_amount*i.price
              end
            end
          end
        end
      end
    end
    @category.each do |a|
      a["lastmonth"]=a["thismonth"]+a["out"]-a["in"]
    end

    @dormitory=Array.new
    EachHouse.all.each do |e|
      if e.position.eql?(params[:warehouse])
        if e.name.eql?("A区主仓库") || e.name.eql?("B区主仓库")
          next
        end
        newdor = {"ticketamount"=>0, "dizhi"=>0, "xiaoxiu"=>0, "heji"=>0}
        newdor["id"]=e.id
        @dormitory<<newdor
      end
    end
    MainList.all.each do |m|
      @yearOfEachItem = m.updated_at.strftime("%Y").to_i
      @monthOfEachItem = m.updated_at.strftime("%m").to_i
      if @yearOfEachItem==@startyear && @monthOfEachItem==@startmonth
        @dormitory.each do |d|
          if m.destination==d['id']
            d['ticketamount'] += 1
            m.items.each do |i|
              if Category.find(i.category_id).inttype==0 #低值
                d['dizhi']+=i.price*i.amount
              else#小修
                d['xiaoxiu']+=i.price*i.amount
              end
            end
          end
        end
      end
    end
    @dormitory.each do |tmpD|
      tmpD["heji"]=tmpD["dizhi"]+tmpD["xiaoxiu"]
    end
  end
end
