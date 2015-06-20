# == Schema Information
#
# Table name: item_subscriptions
#
#  id            :integer          not null, primary key
#  item_id       :integer
#  user_id       :integer
#  amount_credit :decimal(8, 2)
#  start_date    :datetime
#  end_date      :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ItemSubscription < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
end
