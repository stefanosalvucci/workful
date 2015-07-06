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
      @item_in_cart = @carts.map &:item_id
      @items_already_subscribed = current_user.item_subscriptions.map(&:item_id)
      @benefits_left_to_chose = benefits_left_to_chose
      @categories = ItemCategory.where(id: Item.all.pluck('DISTINCT item_category_id')).order('item_categories.order ASC')
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
      render 'pages/dashboard', total_checkout: @total_checkout, change: ['shopping-cart', 'dashboard', 'welcome-message']
    else

    end
  end

  def update
    cart = Cart.find(params['cart_id'])
    cart.amount = params['amount']
    if cart.save
      @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
      @total_discount = 0
      @carts = Cart.where(user_id: current_user.id)
      @item_in_cart = @carts.map &:item_id
      @items_already_subscribed = current_user.item_subscriptions.map(&:item_id)
      @benefits_left_to_chose = benefits_left_to_chose
      @categories = ItemCategory.where(id: Item.all.pluck('DISTINCT item_category_id')).order('item_categories.order ASC')
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
      render 'pages/dashboard', total_checkout: @total_checkout, change: ['shopping-cart', 'welcome-message', 'dashboard']
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
      @item_in_cart = @carts.map &:item_id
      @items_already_subscribed = current_user.item_subscriptions.map(&:item_id)
      @benefits_left_to_chose = benefits_left_to_chose
      @categories = ItemCategory.where(id: Item.all.pluck('DISTINCT item_category_id')).order('item_categories.order ASC')
      @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
    render 'pages/dashboard', total_checkout: @total_checkout, change: ['shopping-cart', 'dashboard', 'welcome-message']
  end
end
