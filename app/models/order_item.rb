# == Schema Information
#
# Table name: order_items
#
#  id            :integer          not null, primary key
#  item_id       :integer
#  user_id       :integer
#  amount_credit :decimal(8, 2)
#  unit          :integer
#  price_unit    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
end
