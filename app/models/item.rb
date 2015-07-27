class Item < ActiveRecord::Base
  belongs_to :item_category
  before_save :validate_amount_save

  has_attached_file :image, :styles => { :medium => "400x170>", :thumb => "200x85" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def validate_amount_save
    self.amount_save ||= 0
  end
end
