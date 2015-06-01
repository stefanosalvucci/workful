class InvitesController < ApplicationController
  layout "frontoffice", only: [:new]
  skip_before_filter :authenticate_user!, only: [:activation, :create_account]
  def index
  end

  def new
    return redirect_to authenticated_url if current_user.company.done_welcome?
    @invite = Invite.new
    @invites = current_user.company.invites
  end

  def create
    @invite = Invite.new invite_params
    @invite.company = current_user.company
    if @invite.save
      redirect_to new_invite_path, notice: "Invite sent to #{@invite.first_name} #{@invite.last_name} (#{@invite.email})."
    else
      render :new
    end
  end

  def activation
    @invite = Invite.find_by_invite_code(params[:invite_code])
    redirect_to root_url if !@invite.present? || @invite.joined?
    @user = User.new
    @user.first_name = @invite.first_name
    @user.last_name = @invite.last_name
    @user.email = @invite.email
    @user.company = @invite.company
  end

  def create_account
    binding.pry
    if params[:user][:password] == "" or params[:user][:password].length < 6
      redirect_to activation_invites_path(params[:invite_code]), flash[:error] => "The password is short"
    else
      binding.pry
      @invite = Invite.where(invite_code: params[:invite_code], joined: false).first
      if @invite.present?
        binding.pry
        @user = User.new(params_user)
        if @user.save
          binding.pry
          CompanyUser.create(company_id: @invite.company.id, user_id: @user.id, role_in_company: 'user')
          @invite.update_attribute :joined, true
          sign_in @user
          binding.pry
          redirect_to authenticated_url
        else
          redirect_to activation_invites_path(params[:invite_code]), flash[:error] => "Something is wrong"
        end 
      else
        redirect_to root_url, flash[:error] => "Something is wrong"
      end
    end
  end

  private
  def invite_params
    params.require(:invite).permit(:first_name, :last_name, :email, :monthly_budget)
  end
  def params_user
    params[:user].permit(:first_name, :last_name, :email, :password)
  end

  def redirect_if_logged_in
    redirect_to authenticated_url if current_user
  end
end
