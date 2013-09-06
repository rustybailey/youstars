class ApiController < ApplicationController
  
  def load_channel_id
    
    inputs  = params[:channel].split(',')
    outputs = []
    
    inputs.each do |string|
      
      if validate_channel_id(string)
        outputs << string
        next
      end
      
      c = Channel.find_by_name(string)
      if c.present?
        outputs << string
        next
      end

      outputs << YoutubeApi.channel_id_for_username(string)

    end

    if outputs.length == 1
      @channel_id = outputs[0]
    else
      @channel_id = outputs
    end

  end

  private
    
  def validate_channel_id(string) 

    (not string.match(/\A[a-zA-Z0-9\_]*\Z/).nil?) and (string[0..1] == 'UC') and (string.length == 24)

  end


  def auto_cache_key(params = {})
    output = []
    {"controller_path" => "#{self.class.name}##{action_name}"}.merge( params ).each{ |k,v| output << "#{k}=#{v}" }
    output.join("|")
  end

end
