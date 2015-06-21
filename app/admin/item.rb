ActiveAdmin.register Item do
  permit_params :name, :min_credit, :max_credit, :image, :item_category_id,
                :amount_save

  menu label: 'Item'

  form :html => {:multipart => true} do |f|
    f.inputs 'Item' do
      f.input :name
      f.input :min_credit
      f.input :max_credit
      f.input :image, :required => false, :as => :file
      f.input :item_category_id, as: :select, collection: ItemCategory.all
      f.input :amount_save
    end
    f.actions
  end
end
