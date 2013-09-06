class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def after_sign_in_path_for( resource )
    if resource.is_a?( User ) 
      if resource.channel_name.present?
        channel_path( resource.channel_name )
      else
        root_path
      end
    else
      super
    end
  end


  rescue_from ActionController::RoutingError do |e|
    message = defined?( e.message ) ? e.message : "Unknown"
    respond_to do |format|
      format.html { render :text => "Error -- #{message}" }
      format.json { render :json => { 'error' => message }.to_json, :status => :forbidden }
    end
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def deny_access!
    raise ActionController::RoutingError.new('Access Denied')
  end

end
