class ItemSubscriptionsController < ApplicationController
  def index
    @item_subscriptions = ItemSubscription.where(user_id: current_user.id)
  end

  def create_subscriptions
    @carts = Cart.where(user_id: current_user.id)
    return redirect_to pages_dashboard_path unless @carts.present?
    if !current_user.has_cc? and @carts.sum(:amount) > current_user.monthly_budget_left
      return redirect_to new_credit_card_users_path
    end
    @carts.each do |cart|
      @item_subscription = ItemSubscription.new
      @item_subscription.item_id = cart.item_id
      @item_subscription.amount = cart.amount
      @item_subscription.user_id = current_user.id
      @item_subscription.start_date = Date.today
      @item_subscription.end_date = Date.today + 1.month
      if current_user.monthly_budget_left > cart.amount
        # company pay
      else
        # user pay
      end
      if @item_subscription.save
        Cart.destroy(cart.id)
      end
    end
    redirect_to item_subscriptions_path
  end

  def edit
    @item_subscription = ItemSubscription.find(params[:id])
  end

  def update
    @item_subscription = ItemSubscription.find(params[:id])
    if @item_subscription.update item_subscriptions_params
      redirect_to item_subscriptions_path
    else
      render :edit, alert: 'Something gone wrong'
    end
  end

  def destroy
    @item_subscription = ItemSubscription.find(params[:id])
    @item_subscription.destroy
    redirect_to item_subscriptions_path
  end

  private
  def item_subscriptions_params
    params.require(:item_subscription).permit(:id, :amount)
  end
end
