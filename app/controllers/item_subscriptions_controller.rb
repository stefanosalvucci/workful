class ItemSubscriptionsController < ApplicationController
  def index
    @item_subscriptions = ItemSubscription.where(user_id: current_user.id)
  end

  def pre_checkout
    @cart_elements = current_user.carts.order(:created_at)
  end

  def create_subscriptions
    @carts = Cart.where(user_id: current_user.id)
    return redirect_to pages_dashboard_path unless @carts.present?
    if @carts.sum(:amount) > current_user.monthly_budget_left
      raise 'should not happen'
      return redirect_to new_credit_card_users_path
    end
    @carts.each do |cart|
      @item_subscription = ItemSubscription.new
      @item_subscription.item_id = cart.item_id
      @item_subscription.amount = cart.amount
      @item_subscription.user_id = current_user.id
      # apparently fields are not on the DB
      # @item_subscription.start_date = Date.today
      # @item_subscription.end_date = Date.today + 1.month
      if @item_subscription.save
        Cart.destroy(cart.id)
      end
    end
    redirect_to subscriptions_confirmation_item_subscriptions_path
  end

  def subscriptions_confirmation
    @active_subscriptions = current_user.item_subscriptions.order(:id)
  end

  def edit
    @item_subscription = ItemSubscription.find(params[:id])
  end

  def update
    @item_subscription = ItemSubscription.find(params[:id])
    if @item_subscription.update item_subscriptions_params
      if params['amount']
        redirect_to item_subscriptions_path
      else
        @active_subscriptions = current_user.item_subscriptions.order(:id)
        render 'subscriptions_confirmation', change: ['subscriptions-confirmation']
      end
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
    params.require(:item_subscription).permit(:id, :amount, :service_email)
  end
end
