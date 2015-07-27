ActiveAdmin.register Request do
  permit_params :fullname, :email, :company_name

  menu label: 'Request'

  form :html => {:multipart => true} do |f|
    f.inputs 'Request' do
      f.input :fullname
      f.input :emal
      f.input :company_name
    end
    f.actions
  end
end
