class ItemSubscriptionsController < ApplicationController
  def index
    @active_subscriptions = current_user.item_subscriptions.order(:id)
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
      @item_subscription = ItemSubscription.find_or_initialize_by(item_id: cart.item_id, user_id: current_user.id)
      @item_subscription.item_id |= cart.item_id
      @item_subscription.user_id |= current_user.id
      @item_subscription.amount += cart.amount
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
      if params['amount']
        redirect_to item_subscriptions_path
      else
        @active_subscriptions = current_user.item_subscriptions.order(:id)
        render '/item_subscriptions/index', change: ['subscriptions-confirmation']
      end
    else
      render :edit, alert: 'Something gone wrong'
    end
  end

  def destroy
    @item_subscription = ItemSubscription.find(params[:id])
    if @item_subscription.destroy
      @active_subscriptions = current_user.item_subscriptions.order(:id)
      render '/item_subscriptions/index', change: ['subscriptions-confirmation']
    else
      render :index, alert: 'Something gone wrong'
    end
  end

  private
  def item_subscriptions_params
    params.require(:item_subscription).permit(:id, :amount, :service_email)
  end
end
