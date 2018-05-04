Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    delete "logout/:id", to: "devise/sessions#destroy", as: :logout
  end
  ActiveAdmin.routes(self)
  root 'dashboards#index' 

  resources :users do
    post :lock, on: :member
    post :unlock, on: :member
  end
  resources :dashboards
  resources :task_catalogs
  resources :procedure_catalogs
  resources :user_preferences

  resources :segments do
    resources :users_imports, only: [:new, :update]
    resources :prep_step_fours, only: [:update] # we need the segment to load the candidacies
    resources :representative_assignations, only: [:new, :update, :destroy]

    resources :prep_processes do
      post :next, on: :member # :collection doesn't require resource id "on: :collection"
      get :complete, on: :member
    end
    resources :segment_messages, only: [:create]
    resources :users do
      post :lock, on: :member # requires id of the resource "on: :member"
      post :unlock, on: :member
    end
  end

  resources :transfer_users, only: [:new, :create] do
    get :select, on: :collection
  end

  resources :prep_step_threes, only: [:update]
  resources :prep_step_twos, only: [:update]
  resources :profiles, only: [:edit, :update]

  post 'users_batch_action', to: 'users_batch_actions#create'

  # handles /
  get '', to: redirect("/#{I18n.locale}")
end
