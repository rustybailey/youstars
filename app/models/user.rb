class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  attr_accessible :email, :password, :provider, :uid, :name, :oauth2_token, :refresh_token, :guid, :channel_name, :custom_suggestions

  has_one :channel
  has_many :views 
  has_many :ratings

  def yt_client
    YouTubeIt::OAuth2Client.new(
      client_access_token:  self.oauth2_token,
      client_refresh_token: self.refresh_token,
      client_id:            ENV['YOUTUBE_KEY'], 
      client_secret:        ENV['YOUTUBE_SECRET'],
      dev_key:              ENV['YOUTUBE_API']
    )
  end


  def get_token

    begin
      omniauth = yt_client.refresh_access_token!
      self.update_attributes!(:oauth2_token => omniauth.token)
    rescue Exception => e
      message = e.class == OAuth2::Error ? e.response.body : e.message
      raise message
    end

    self.oauth2_token

  end

  def self.find_for_youtube_oauth(auth, signed_in_resource=nil)
    user = User.where( :provider => auth.provider, :uid => auth.uid ).first
    unless user
      user = User.create(
        provider:       auth.provider,
        uid:            auth.uid,
        email:          auth.info.email,
        password:       Devise.friendly_token[0,20],
        oauth2_token:   auth.token,
        refresh_token:  auth.refresh_token
      )
      Resque.enqueue_in_with_queue( :immediate, 0, UserDataJob, user.id )
    end

    user
  end

  def rated_videos(score = nil)
    Video.where(:id => ratings_relation.map(&:id))
  end

  def liked_videos(score = 3)
    ratings_relation = ratings
    ratings_relation = ratings_relation.where( ["score >= ?", score] ) unless score.nil?
    
    Video.where(:id => ratings_relation.map(&:id))
  end
  
  def disliked_videos(score = 2)
    ratings_relation = ratings
    ratings_relation = ratings_relation.where( ["score <= ?", score] ) unless score.nil?
    
    Video.where(:id => ratings_relation.map(&:id))
  end

end
