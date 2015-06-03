class PagesController < ApplicationController
  def index
  end

  def dashboard
    return redirect_to new_invite_path if !current_user.company.done_welcome? and current_user.company.done_welcome_step == "configure" and current_user.company_user.role_in_company == "owner"
    return redirect_to configure_companies_path if !current_user.company.done_welcome? and !current_user.company.done_welcome_step.present? and current_user.company_user.role_in_company == "owner"
    @categories = ItemCategory.all.order('item_categories.order ASC')
    @total_checkout = OrderItem.where(user_id: current_user.id).sum(:amount_credit)
  end
end
