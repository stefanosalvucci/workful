class PagesController < ApplicationController

  layout "landing", only: [:landing]
  skip_before_filter :authenticate_user!, only: [:landing, :yc_fellowship]

  def index
  end

  def dashboard
    return redirect_to configure_companies_path if !current_user.company.done_welcome? and current_user.company_user.role_in_company == "owner"
    @categories = ItemCategory.where(id: Item.all.pluck('DISTINCT item_category_id')).order('item_categories.order ASC')
    @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
    @carts = Cart.where(user_id: current_user.id)
    @item_in_cart = @carts.map &:item_id
    @items_already_subscribed = current_user.item_subscriptions.map(&:item_id)
    @total_discount = 0
    @benefits_left_to_chose = benefits_left_to_chose
    @carts.each do |cart|
      @total_discount = @total_discount + cart.item.amount_save
    end
    @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
  end

  def landing
  end

  def yc_fellowship

    yc_user = User.find_by_email('hello@ycombinator.com')
    sign_in yc_user

    @categories = ItemCategory.where(id: Item.all.pluck('DISTINCT item_category_id')).order('item_categories.order ASC')
    @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
    @carts = Cart.where(user_id: current_user.id)
    @item_in_cart = @carts.map &:item_id
    @items_already_subscribed = current_user.item_subscriptions.map(&:item_id)
    @total_discount = 0
    @benefits_left_to_chose = benefits_left_to_chose
    @carts.each do |cart|
      @total_discount = @total_discount + cart.item.amount_save
    end
    @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
  end
end
