class ItemsController < ApplicationController
  before_action :current_user_must_be_item_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_item_user
    item = Item.find(params[:id])

    unless current_user == item.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @items = current_user.items.all
    @table_title = "All Items"

    render("items/table.html.erb")
  end

  def fridge
    @items = current_user.items.where(:location => 0)
    @table_title = "Items in your Fridge"

    render("items/table.html.erb")
  end

  def freezer
    @items = current_user.items.where(:location => 1)
    @table_title = "Items in your Freezer"

    render("items/table.html.erb")
  end

  def pantry
    @items = current_user.items.where(:location => 2)
    @table_title = "Items in your Pantry"

    render("items/table.html.erb")
  end

  def fruitbowl
    @items = current_user.items.where(:location => 3)
    @table_title = "Items in your Fruit Bowl"
    render("items/table.html.erb")
  end

  def other
    @items = current_user.items.where(:location => 4)
    @table_title = "Items in Other Locations"

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

  def create
    @item = Item.new

    @item.title = params[:title]
    @item.expiration_date = params[:expiration_date]
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
