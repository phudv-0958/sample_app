class UsersController < ApplicationController
  before_action :find_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.scope_order_name.page(params[:page])
      .per Settings.paginate.record_per_page
  end

  def show
    @microposts = @user.microposts.scope_order_created_at.page(params[:page])
      .per Settings.micropost.show.feed_items
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".activation"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".update_profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    @user.destroyed? ? flash[:success] = t(".delete_success")
      : flash[:danger] = t(".delete_error")
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger]  = t ".error"
    redirect_to root_url
  end

  def correct_user
    return if current_user? @user
    redirect_to root_url
    flash[:danger]  = t ".not_access"
  end

  def admin_user
    return if current_user.admin?
    flash[:danger]  = t ".not_delete"
    redirect_to root_url
  end
end
