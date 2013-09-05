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

  namespace :suggest do

    get '/channels',                  :controller => 'channels', :action => 'user'
    get '/channels/:youtube_id',      :controller => 'channels', :action => 'channel'

    get '/videos',                    :controller => 'videos', :action => 'user'
    get '/videos/related/:youtube_id',:controller => 'videos', :action => 'related'
    get '/videos/most_watched',       :controller => 'videos', :action => 'most_watched'
    get '/videos/recently_watched',   :controller => 'videos', :action => 'recently_watched'

  end

end
