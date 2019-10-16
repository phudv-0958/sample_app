class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".correct_email"
      redirect_to root_url
    else
      flash.now[:danger] =  t ".incorrect_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".empty_password")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t ".reset_success"
      redirect_to @user
    else
      flash.now[:danger] =  t ".error_update"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::PASSWORD_RESET_PARAMS
  end

  def get_user
    @user = User.find_by email: params[:email]

    return if @user
    flash[:danger]  = t ".error"
    redirect_to new_password_reset_url
  end

  def valid_user
    return if @user && @user.activated? && @user.authenticated?(:reset, params[:id])
    flash[:danger] = t ".not_valid"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t ".expired"
    redirect_to new_password_reset_url
  end
end
