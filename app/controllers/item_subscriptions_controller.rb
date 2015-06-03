class ItemSubscriptionsController < ApplicationController
  def index
    @item_subscriptions = ItemSubscription.where(user_id: current_user.id)
  end

  def create_subscriptions
    @order_items = OrderItem.where(user_id: current_user.id)
    return redirect_to pages_dashboard_path unless @order_items.present?
    @order_items.each do |order_item|
      @item_subscription = ItemSubscription.new
      @item_subscription.item_id = order_item.item_id
      @item_subscription.amount_credit = order_item.amount_credit
      @item_subscription.user_id = current_user.id
      @item_subscription.start_date = Date.today
      @item_subscription.end_date = Date.today + 1.month
      if @item_subscription.save
        OrderItem.destroy(order_item.id)
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
    params.require(:item_subscription).permit(:id, :amount_credit)
  end
end
