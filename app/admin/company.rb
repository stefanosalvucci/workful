ActiveAdmin.register Company do

  permit_params :name, :url, :done_welcome, :done_welcome_step, :phone_number,
                :email_company

  menu label: 'Companies'
end
