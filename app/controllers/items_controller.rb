class ItemsController < ApplicationController
  before_action :current_user_must_be_item_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_item_user
    item = Item.find(params[:id])

    unless current_user == item.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @items = current_user.items.all.order(:expiration_date)
    @table_title = "All Items"
    @new_title = "New Item"
    @loc = nil

    render("items/table.html.erb")
  end

  def fridge
    @items = current_user.items.where(:location => 0).order(:expiration_date)
    @table_title = "Items in your Fridge"
    @new_title = "New Fridge Item"
    @loc = "fridge"

    render("items/table.html.erb")
  end

  def freezer
    @items = current_user.items.where(:location => 1).order(:expiration_date)
    @table_title = "Items in your Freezer"
    @new_title = "New Freezer Item"
    @loc = "freezer"


    render("items/table.html.erb")
  end

  def pantry
    @items = current_user.items.where(:location => 2).order(:expiration_date)
    @table_title = "Items in your Pantry"
    @new_title = "New Pantry Item"
    @loc = "pantry"

    render("items/table.html.erb")
  end

  def fruitbowl
    @items = current_user.items.where(:location => 3).order(:expiration_date)
    @table_title = "Items in your Fruit Bowl"
    @new_title = "New Fruit Bowl Item"
    @loc = "fruitbowl"

    render("items/table.html.erb")
  end

  def other
    @items = current_user.items.where(:location => 4).order(:expiration_date)
    @table_title = "Items in Other Locations"
    @new_title = "New Other Item"
    @loc = "other"

    render("items/table.html.erb")
  end


  def show
    @item = Item.find(params[:id])

    render("items/show.html.erb")
  end

  def new
    @item = Item.new

    render("items/new.html.erb")
  end

  def new_fridge_item
    @item = Item.new
    @location = 0
    @loc = "Fridge"

    render("items/new_location_item.html.erb")
  end

  def new_freezer_item
    @item = Item.new
    @location = 1
    @loc = "Freezer"

    render("items/new_location_item.html.erb")
  end

  def new_pantry_item
    @item = Item.new
    @location = 2
    @loc = "Pantry"

    render("items/new_location_item.html.erb")
  end

  def new_fruitbowl_item
    @item = Item.new
    @location = 3
    @loc = "Fruit Bowl"

    render("items/new_location_item.html.erb")
  end

  def new_other_item
    @item = Item.new
    @location = 4
    @loc = "Other"

    render("items/new_location_item.html.erb")
  end

  def create
    @item = Item.new

    @item.title = params[:title]
    input_date = params[:expiration_date]
    split_date = input_date.split("/")
    date = Date.new(split_date[2].to_i, split_date[0].to_i, split_date[1].to_i)
    @item.expiration_date = date
    @item.location = params[:location]
    @item.image_url = params[:image_url]
    @item.user_id = params[:user_id]

    save_status = @item.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/items/new", "/create_item"
        redirect_to("/items")
      else
        redirect_back(:fallback_location => "/", :notice => "Item created successfully.")
      end
    else
      render("items/new.html.erb")
    end
  end

  def edit
    @item = Item.find(params[:id])

    render("items/edit.html.erb")
  end

  def update
    @item = Item.find(params[:id])

    @item.title = params[:title]
    input_date = params[:expiration_date]
    split_date = input_date.split("/")
    date = Date.new(split_date[2].to_i, split_date[0].to_i, split_date[1].to_i)
    @item.expiration_date = params[:expiration_date]
    @item.location = params[:location]
    @item.image_url = params[:image_url]
    @item.user_id = params[:user_id]

    save_status = @item.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/items/#{@item.id}/edit", "/update_item"
        redirect_to("/items/#{@item.id}", :notice => "Item updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Item updated successfully.")
      end
    else
      render("items/edit.html.erb")
    end
  end

  def destroy
    @item = Item.find(params[:id])

    @item.destroy

    if URI(request.referer).path == "/items/#{@item.id}"
      redirect_to("/", :notice => "Item deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Item deleted.")
    end
  end
end
