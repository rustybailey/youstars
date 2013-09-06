Dir["#{Rails.root}/lib/*.rb"].each {|file| load file}

class Object

  # Deep existence digging
  def dig(*path)
    path.inject(self) do |location, key|
      location.respond_to?(:[]) ? location[key] : nil
    end
  end
  
end

def is_a_number?(s)
  s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true 
end