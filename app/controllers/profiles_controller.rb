class ProfilesController < ApplicationController
  before_action :allow_without_password, only: [:update]
  before_action :load_groups

  def edit
    @user = User.unscoped.find(params[:id])
    authorize! :manage_profile, @user
  end

  def update
    @user = User.unscoped.find(params[:id])
    authorize! :manage_profile, @user
    begin
      @user.update(user_params)
    rescue ActiveRecord::RecordNotUnique => e
      @user.user_groups.each do |ug|
        ug.errors.add(:group_id, t(:cant_send_duplicates)) if ug.new_record?
      end
      flash[:error] = t(:errors_updating_the_profile)
    end
    flash[:notice] = t(:success_profile_update) if flash[:error].blank? && @user.errors.empty?
    render :edit
  end

  private

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
