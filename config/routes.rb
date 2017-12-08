Rails.application.routes.draw do
  scope "/:locale", defaults: { locale: 'es' } do
    devise_for :users
    ActiveAdmin.routes(self)
    root 'dashboards#index' 

    resources :users
    resources :dashboards
    resources :task_catalogs
    resources :procedure_catalogs
  end

  get '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }

  # handles /
  get '', to: redirect("/#{I18n.locale}")
end
