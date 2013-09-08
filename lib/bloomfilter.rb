class Bloomfilter
  attr_accessor :name, :block_width, :block_count, :k, :base_filter

  def initialize(name, block_width, block_count, k, base_filter = nil, redis = Resque.redis)
    @name = name

    # filters can be compressed by storing them as deltas against the base filter
    @base_filter = base_filter

    # bytes per filter block
    @block_width = block_width

    # number of filter blocks
    @block_count = block_count

    # bits per hash key
    @bit_depth = (Math.log(@block_width * @block_count * 8) / Math.log(2)).floor

    # number of bits set per element
    @k = k

    @redis = redis
  end


  def hash_string(string, seed)
    value = (string + seed.to_s).hash
    value & (2**@bit_depth - 1)
  end


  def set_bit(index)
    block_index = index / (@block_width * 8)
    bit_index   = index % (@block_width * 8)

    if ! (@redis.getbit("#{ @name }_compressed", 1) == 1)
      @redis.setbit("#{ @name }_#{ block_index }", bit_index, 1)

    else
      base_bit = @redis.getbit("#{ @base_filter.name }_#{ block_index }", bit_index)

      @redis.setbit("#{ @name }_#{ block_index } ", bit_index, 1 ^ base_bit)
    end
  end


  def get_bit(index)
    block_index = index / (@block_width * 8)
    bit_index   = index % (@block_width * 8)
    
    if ! (@redis.getbit("#{ @name }_compressed", 1) == 1)
      @redis.getbit("#{ @name }_#{ block_index }", bit_index) == 1
      
    else
      @redis.getbit("#{ @base_filter.name }_#{ block_index }", bit_index) ^ @redis.getbit("#{ @name }_#{ block_index }", bit_index) == 1

    end
  end


  def compress!
    return nil if @base_filter.nil?
    return nil if @redis.getbit("#{ @name }_compressed", 1) == 1

    (0...@block_count).each do |block_index|
      blockname = "#{ @name }_#{ block_index }"
      basename  = "#{ @base_filter.name }_#{ block_index }"

      if @redis.exists(blockname)

        @redis.bitop 'xor', blockname, blockname, basename

      end

    end

    @redis.setbit("#{ @name }_compressed", 1, 1)

    self
  end


  def add_element(string)
    @k.times do |i|
      set_bit hash_string(string, i)
    end

    string
  end


  def test_element(string)
    @k.times do |i|
      return false unless get_bit(hash_string(string, i))
    end

    true
  end


end
