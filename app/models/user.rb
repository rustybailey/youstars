class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  attr_accessible :email, :password, :provider, :uid, :name


  def self.find_for_youtube_oauth(auth, signed_in_resource=nil)
    user = User.where( :provider => auth.provider, :uid => auth.uid ).first

    unless user
      user = User.create(
        provider:   auth.provider,
        uid:        auth.uid,
        email:      auth.info.email,
        password:   Devise.friendly_token[0,20]
      )
    end

    user
  end

  def self.new_with_session(params, session)

    super.tap do |user|
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
