class InvitesController < ApplicationController
  layout "frontoffice", only: [:new, :share_invite_url_frontoffice]
  skip_before_filter :authenticate_user!, only: [:activation, :create_account, :request_demo]
  def index
  end

  def share_invite_url_frontoffice
    @company = current_user.company
  end

  def request_demo
    req = Request.new(
      fullname: params['name'],
      email: params['email'],
      company_name: params['company']
    )
    if req.save
      #ApplicationMailer.request_demo_confirmation(req.email).deliver_now
      render json: {result: 'OK'}
    else
      render json: {result: 'SEND_ERROR'}
    end
  end

  def activation
    @company = Company.find_by_invite_code(params[:invite_code])
    redirect_to root_url unless @company.present? || current_user
    @user = User.new
    @user.company = @company
  end

  def create_account
    if params[:user][:password] == "" or params[:user][:password].length < 6
      redirect_to activation_invites_path(params[:invite_code]), flash[:error] => "The password is short"
    else
      @company = Company.where(invite_code: params[:invite_code]).take
      if @company.present?
        @user = User.new(params_user)
        @user.monthly_budget = @company.monthly_budget
        @user.email = @user.email + '@' + @company.domain
        if @user.save
          CompanyUser.create(company_id: @company.id, user_id: @user.id, role_in_company: 'user')
          sign_in @user
          redirect_to authenticated_url
        else
          redirect_to activation_invites_path(params[:invite_code]), flash[:error] => "Something is wrong"
        end 
      else
        redirect_to root_url, flash[:error] => "Something is wrong"
      end
    end
  end

  def wizard_invite_done
    redirect_to authenticated_url, notice: ""
  end

  private
  def params_user
    params[:user].permit(:first_name, :last_name, :email, :password)
  end

  def redirect_if_logged_in
    redirect_to authenticated_url if current_user
  end
end
