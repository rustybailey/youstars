class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_youtube_oauth( request.env["omniauth.auth"], current_user )


    client = YouTubeIt::OAuth2Client.new(
      :client_access_token => request.env["omniauth.auth"]["credentials"]["token"],
      :client_id           => ENV['YOUTUBE_KEY'],
      :client_secret       => ENV['YOUTUBE_SECRET']
    )

    profile = nil
    begin

      profile = client.profile

    rescue Exception => e

      if e.response.present? and e.response.status == 401 and e.response.body =~ /NoLinkedYouTubeAccount/
        flash[:alert] = "This YouTube account appears to not have a Channel associated with it.  Please contact <a href='mailto:support@fullscreen.net'>Fullscreen Support</a> to help Troubleshoot."
        redirect_to root_url and return
      else
        flash[:alert] = "There was an unknown error with this YouTube account.  Please contact <a href='mailto:support@fullscreen.net'>Fullscreen Support</a> to help Troubleshoot."
        redirect_to root_url and return
      end

    end

    if profile.nil?
      flash[:alert] = "There was an unknown error with this YouTube account.  Please contact <a href='mailto:support@fullscreen.net'>Fullscreen Support</a> to help Troubleshoot."
      redirect_to root_url
    end


    if @user.persisted?
      
      @user.update_attributes(
        email:          request.env["omniauth.auth"]["info"]["email"],
        oauth2_token:   request.env["omniauth.auth"]["credentials"]["token"],
        refresh_token:  request.env["omniauth.auth"]["credentials"]["refresh_token"],
        guid:           profile.user_id,
        channel_name:   profile.username

      )

      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "YouTube") if is_navigational_format?
    else
      session["devise.google_oauth2"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end

end