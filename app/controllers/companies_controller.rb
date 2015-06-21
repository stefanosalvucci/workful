class CompaniesController < ApplicationController
  layout "frontoffice", only: [:configure]
  def configure
    #return redirect_to new_invite_path if !current_user.company.done_welcome? and current_user.company.done_welcome_step == "configure"
    @company = current_user.company
  end

  def update
    @company = current_user.company
    if @company.update company_update_params
      @company.update_attribute :done_welcome, true
      redirect_to share_invites_path
    else
      render :configure
    end
  end

  private

  def company_update_params
    params.require(:company).permit(:name, :domain, :monthly_budget)
  end
end
