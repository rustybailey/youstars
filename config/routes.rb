Youstars::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#index'
  get  "login" => "home#login"


  get '/:channel_name' => 'home#index'
  get '/channel/:channel',        :controller => 'channel', :action => 'show'
  get '/channel/:channel/videos', :controller => 'channel', :action => 'videos'
  get '/channel/:channel/topics', :controller => 'channel', :action => 'topics'
  get '/channel/:channel/stream', :controller => 'channel', :action => 'stream'

  put  '/channel/:youtube_id',       :controller => 'channel', :action => 'create'
  post '/channel/:youtube_id',       :controller => 'channel', :action => 'update'

  namespace :suggest do

    get '/channels',                  :controller => 'channels', :action => 'user'
    get '/channels/:channel',         :controller => 'channels', :action => 'related'

    get '/videos',                    :controller => 'videos', :action => 'user'
    get '/videos/related/:youtube_id',:controller => 'videos', :action => 'related'
    get '/videos/most_watched',       :controller => 'videos', :action => 'most_watched'
    get '/videos/recently_watched',   :controller => 'videos', :action => 'recently_watched'
    get '/videos/trending',           :controller => 'videos', :action => 'trending'
    get '/videos/popular',            :controller => 'videos', :action => 'popular'
    get '/videos/featured',           :controller => 'videos', :action => 'featured'

  end

end
