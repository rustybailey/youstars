HireFire::Resource.configure do |config|

  config.dyno(:worker) do
    HireFire::Macro::Resque.queue(:immediate, :hourly, :daily, :two_days, :weekly, :monthly, :open)
  end

end
