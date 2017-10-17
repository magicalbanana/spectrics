Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :spec_profiles

  constraints subdomain: "hooks" do
    post '/:circle_ci' => 'webhooks#receive', as: :receive_webhooks
  end

end
