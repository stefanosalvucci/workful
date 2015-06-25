class UsersController < ApplicationController
  def new_credit_card

  end

  def save_credit_card
    @user = User.find(current_user.id)
    # stripe_token = params[:stripeToken]
    # stripe_customer = Stripe::Customer.create(
    #   :description => "Customer for #{current_user.email} (#{current_user.first_name} #{current_user.last_name})",
    #   :email => current_user.email,
    #   :source => stripe_token
    # )
    if @user.update_attribute :stripe_id, 23 # random number to test subscription
      if @user.has_order?
        redirect_to root_path, notice: 'Credit card saved, you can now finish the order'
      else
        redirect_to root_path, notice: 'Credit card saved'
      end
    else
      render :new_credit_card, alert: 'Something gone wrong'
    end
  end
end
