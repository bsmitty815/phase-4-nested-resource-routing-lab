class ItemsController < ApplicationController
  # returns a 404 response if the user/item is not found
  # global error rescue
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  

  def index


    if params[:user_id]
      # returns an array of all items belonging to a user
      user_id = User.find(params[:user_id])
      items = user_id.items
    #  render json: items, include: :user

    else
      #  render json: items, include: :user
      items = Item.all

    end
    render json: items, include: :user
    
  end

  def show

    # returns the item with the matching id
    item = Item.find(params[:id])
    render json: item, include: :user

  end

  def create
    user_id = User.find(params[:user_id])
    # creates a new item belonging to a user
    
    item = user_id.items.create(item_params)
    # returns the newly created item
    # returns a 201 created status if the item was created
    render json: item, status: :created

    
  end

  private



  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response
    render json: { errors: "Not Found" }, status: :not_found
  end

end
