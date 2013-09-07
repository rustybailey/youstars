class Ashurbanipal
  # Named for the Assyrian king who amassed one of the first libraries of written documents



  def initialize( klass, uid = nil, params = {} )

    @controller          = klass.new
    @controller.request  = ActionDispatch::TestRequest.new
    @controller.response = ActionDispatch::TestResponse.new

    if uid.present?
      @controller.session[:user] = {
        'uid' => uid, 
        :credentials => {
          :expires_at => (Time.now + 1.day).to_i
        }
      }
      @controller.session[:user_created_at] = Time.now.to_i    
    end

    @controller.request.format  = "json"
    @controller.params          = params

  end

  def controller
    @controller
  end

  def send( proc )
    proc = [ proc ] unless proc.is_a? Array
    proc.each do |p| 
      begin
        @controller.send( p )
      rescue Exception => exception
        return
      end
    end
  end

  def response
    @controller.response
  end

  def before_filters( route )
    # Gotta call them before_filters
    @controller._process_action_callbacks.each do |callback|
      
      next if     callback.filter == :verify_authenticity_token
      next unless callback.kind == :before

      if callback.options[:except].present?
        next if callback.options[:except].include?( route.to_sym )
      elsif callback.options[:only].present?
        next unless callback.options[:only].include?( route.to_sym )
      end

      Rails.logger.info "==Applying Filter: #{callback.filter}"
      @controller.send( callback.filter.to_s )

    end
  end



end