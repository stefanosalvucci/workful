# == Schema Information
#
# Table name: item_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order      :integer
#

class ItemCategory < ActiveRecord::Base
  has_many :items
end
