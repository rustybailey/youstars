Youstars::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  get  "login" => "home#login"

  get '/:woo' => 'home#index'
end
