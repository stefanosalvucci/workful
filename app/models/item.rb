# == Schema Information
#
# Table name: items
#
#  id                 :integer          not null, primary key
#  name               :string
#  min_credit         :integer          default(0)
#  decimal            :integer          default(0)
#  max_credit         :integer          default(0)
#  item_category_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  order              :integer
#  amount_save        :integer
#

class Item < ActiveRecord::Base
  belongs_to :item_category

  has_attached_file :image, :styles => { :medium => "400x170>", :thumb => "200x85" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
