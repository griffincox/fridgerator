Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "items#index"
  # Routes for the Item resource:
  # CREATE
  get "/items/new/fridge_item", :controller => "items", :action => "new_fridge_item"
  get "/items/new/freezer_item", :controller => "items", :action => "new_freezer_item"
  get "/items/new/fruitbowl_item", :controller => "items", :action => "new_fruitbowl_item"
  get "/items/new/pantry_item", :controller => "items", :action => "new_pantry_item"
  get "/items/new/other_item", :controller => "items", :action => "new_other_item"
  get "/items/new", :controller => "items", :action => "new"
  post "/create_item", :controller => "items", :action => "create"

  # READ
  get "/items", :controller => "items", :action => "index"
  get "/items/fridge", :controller => "items", :action => "fridge"
  get "/items/freezer", :controller => "items", :action => "freezer"
  get "/items/pantry", :controller => "items", :action => "pantry"
  get "/items/fruitbowl", :controller => "items", :action => "fruitbowl"
  get "/items/other", :controller => "items", :action => "other"

  # UPDATE
  get "/items/:id/edit", :controller => "items", :action => "edit"
  post "/update_item/:id", :controller => "items", :action => "update"

  # DELETE
  get "/delete_item/:id", :controller => "items", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  # get "/users", :controller => "users", :action => "index"
  # get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
