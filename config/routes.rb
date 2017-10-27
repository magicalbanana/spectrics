Rails.application.routes.draw do
  resources :main_panels
  resources :users
  resources :active_builds
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main_panels#index'

  resources :spec_profiles

  mount ActionCable.server => '/cable' #May not be necessary anymore

  constraints subdomain: "hooks" do
    post '/:circle_ci' => 'webhooks#receive', as: :receive_webhooks
  end

end
