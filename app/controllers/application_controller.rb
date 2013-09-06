class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def auto_cache_key(params = {})
    output = []
    {"controller_path" => "#{self.class.name}##{action_name}"}.merge( params ).each{ |k,v| output << "#{k}=#{v}" }
    output.join("|")
  end
end
