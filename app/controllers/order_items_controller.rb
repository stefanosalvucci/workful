class OrderItemsController < ApplicationController

  def create
    order_item = OrderItem.new
    order_item.item_id = params[:item_id]
    order_item.user_id = current_user.id
    order_item.amount_credit = params[:amount_credit]
    if order_item.save
      @total_checkout = OrderItem.where(user_id: current_user.id).sum(:amount_credit)
      @order_items = OrderItem.where(user_id: current_user.id)
      @total_discount = 0
      @order_items.each do |order_item|
        @total_discount = @total_discount + order_item.item.amount_save
      end
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
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
