class UsersBatchActionsController < ApplicationController
  def create
    @users = User.where(id: params[:users_ids])
    authorize! :manage_user_batch_action, @users
    run_batch_action
  end

  def run_batch_action
    @users_with_errors = []
    User.transaction do
      send(params[:batch_action])
      @users.each do |user|
        @users_with_errors << user if !user.errors.empty?
      end
      set_action_message
      if @users_with_errors.present?
        flash[:warning] = "Llame al soporte técnico"
        raise ActiveRecord::Rollback
      end
    end
  end

  def delete
    @users.destroy_all
  end

  def set_action_message
    @action_message = case params[:batch_action]
                      when 'delete'
                        @users_with_errors.empty? ?
                          t(:deleted_users_successfully) :
                          t(:failed_to_delete_users, users: @users_with_errors.map(&:name).join(', '))
                      end
  end
end
