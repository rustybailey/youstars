class HourlyData

  @queue = :immediate

  def self.perform
    User.select("id").find_in_batches(batch_size: 100) do |users|
      users.each do |u|
        Resque.enqueue( UserDataJob, u.id )
      end
    end
  end

end