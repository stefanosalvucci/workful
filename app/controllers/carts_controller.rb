class CartsController < ApplicationController

  def create
    cart = Cart.new
    cart.item_id = params[:item_id]
    cart.user_id = current_user.id
    cart.amount = params[:amount]
    if cart.save
      @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
      @carts = Cart.where(user_id: current_user.id)
      @total_discount = 0
      @carts.each do |cart|
        @total_discount = @total_discount + cart.item.amount_save
      end
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
      render 'shared/_cart_create', total_checkout: @total_checkout, change: ['shopping-cart']
    else

    end
  end

  def update
    cart = Cart.find(params['cart_id'])
    cart.amount = params['amount']
    if cart.save
      @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
      @total_discount = 0
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
      render 'shared/_cart_create', total_checkout: @total_checkout, change: ['shopping-cart']
    else

    end
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
    @carts = Cart.where(user_id: current_user.id)
      @total_discount = 0
      @carts.each do |cart|
        @total_discount = @total_discount + cart.item.amount_save
      end
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
    render 'shared/_cart_create', total_checkout: @total_checkout, change: ['shopping-cart']
  end
end
