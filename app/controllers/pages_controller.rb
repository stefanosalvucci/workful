class PagesController < ApplicationController
  def index
  end

  def dashboard
    return redirect_to configure_companies_path if !current_user.company.done_welcome? and current_user.company_user.role_in_company == "owner"
    @categories = ItemCategory.where(id: Item.all.pluck('DISTINCT item_category_id')).order('item_categories.order ASC')
    @total_checkout = Cart.where(user_id: current_user.id).sum(:amount)
    @carts = Cart.where(user_id: current_user.id)
    @total_discount = 0
    @carts.each do |cart|
      @total_discount = @total_discount + cart.item.amount_save
    end
    @total_checkout_credit = @total_checkout + (@total_checkout*@total_discount/100)
  end
end
