ActiveAdmin.register ItemCategory do

  permit_params :name, :order

  menu label: 'Categories'
end
