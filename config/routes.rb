Youstars::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  get  "login" => "home#login"


  get '/:channel_name' => 'home#index'
  get '/channel/:youtube_id',        :controller => 'channel', :action => 'show'
  get '/channel/:youtube_id/videos', :controller => 'channel', :action => 'videos'
  get '/channel/:youtube_id/topics', :controller => 'channel', :action => 'topics'
  get '/channel/:youtube_id/stream', :controller => 'channel', :action => 'stream'

  put  '/channel/:youtube_id',       :controller => 'channel', :action => 'create'
  post '/channel/:youtube_id',       :controller => 'channel', :action => 'update'

end
