class UsersController < ApplicationController

  before_action :allow_without_password, only: [:update]
  before_action :authorize!
  before_action :load_groups, only: [:index, :update]
  before_action :load_users, only: [:index, :update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups
  end

  def new
    @user = User.new
    @groups = Group.all
  end

  def edit
    @user = User.find(params[:id])
    @groups = Group.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    begin
      @user.update(user_params)
    rescue ActiveRecord::RecordNotUnique => e
      @user.user_groups.each do |ug|
        ug.errors.add(:group_id, t(:cant_send_duplicates)) if ug.new_record?
      end
      flash[:error] = t(:errors_updating_the_user)
    end
    flash[:notice] = t(:success_user_update) if flash[:error].blank? && @user.errors.empty?
    render :index 
  end

  #def destroy
  #  @user = User.find(params[:id])
  #  @user.destroy
  #  redirect_to users_path
  #end

  def lock
    @user = User.find(params[:id])
    if !(current_user == @user)
      @user.lock_access!
      flash[:success] = t(:lock_access)
    else
      flash[:notice] = t(:cant_perform_this_action)
    end
    redirect_to users_path
  end

  def unlock
    @user = User.find(params[:id])
    if !(current_user == @user)
      @user.unlock_access!
      flash[:success] = t(:unlock_access)
    else
      flash[:alert] = t(:cant_perform_this_action)
    end
    redirect_to users_path
  end

  private

  def load_users
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def load_groups
    @groups = Group.all
  end

  def user_params
    params.require(:user).
      permit(:username, :email, :password, :password_confirmation, :name, :father_last_name, :mother_last_name, 
              user_groups_attributes: [:id, :user_id, :group_id, :_destroy])
  end

  def allow_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
