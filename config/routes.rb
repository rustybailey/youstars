Youstars::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  get  "login" => "home#login"

  get "/creator/:youtube_id/videos", :controller => "creator", :action => "videos"

end
