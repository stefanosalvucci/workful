class CompaniesController < ApplicationController
  layout "frontoffice", only: [:configure]
  def configure
    #return redirect_to new_invite_path if !current_user.company.done_welcome? and current_user.company.done_welcome_step == "configure"
    @company = current_user.company
  end

  def update
    @company = current_user.company
    binding.pry
    stripe_token = params[:stripeToken]
    stripe_customer = Stripe::Customer.create(
      :description => "Customer for #{current_user.email} (#{current_user.first_name} #{current_user.last_name})",
      :email => current_user.email,
      :source => stripe_token
    )
    binding.pry
    @company.stripe_id = stripe_customer['id']
    if @company.update company_update_params
      @company.update_attribute :done_welcome_step, "configure"
      redirect_to new_invite_path
    else
      render :configure
    end
  end

  private

  def company_update_params
    params.require(:company).permit(:name, :url, :phone_number, :email_company)
  end
end
