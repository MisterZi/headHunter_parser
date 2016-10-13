
uri = URI.parse("redis://localhost:6379/")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

require 'rake'
require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:setup" => :environment

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque/scheduler'

    Resque.redis = 'localhost:6379'

    Resque.schedule = YAML.load_file("#{Rails.root}/config/rescue_schedule.yml")

  end
  task :scheduler => :setup_schedule
end