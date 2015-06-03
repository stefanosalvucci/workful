class OrderItemsController < ApplicationController

  def create
    order_item = OrderItem.new
    order_item.item_id = params[:item_id]
    order_item.user_id = current_user.id
    order_item.amount_credit = params[:amount_credit]
    if order_item.save
      @total_checkout = OrderItem.where(user_id: current_user.id).sum(:amount_credit)
      render 'shared/_order_items_create', total_checkout: @total_checkout, change: ['shopping-cart']
    else

    end
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    @total_checkout = OrderItem.where(user_id: current_user.id).sum(:amount_credit)
    render 'shared/_order_items_create', total_checkout: @total_checkout, change: ['shopping-cart']
  end
end
