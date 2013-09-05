class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  attr_accessible :email, :password, :provider, :uid, :name, :oauth2_token, :refresh_token, :guid, :channel_name

  has_one :channel

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
    end

    user
  end

end
