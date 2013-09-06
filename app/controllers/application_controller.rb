class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
