require 'simple_slack'
require 'clockwork'
include Clockwork

def parse_days(days)
  if days.nil?
    return parse_values("Monday, Tuesday, Wednesday, Thursday, Friday")
  else
    parse_values(days)
  end
end

def parse_regular_times(times)
  if times.nil?
    return parse_values("10:00, 11:00, 14:00, 15:00, 16:00, 17:00")
  else
    parse_values(times)
  end
end

def parse_values(env)
  env.split(",").map{ |e| e.strip }
end

def toggl_job(type)
  client = SimpleSlack::Client.new(ENV['GEM_SIMPLE_SLACK_API_TOKEN'])
  toggl  = client.toggl(ENV['GEM_SIMPLE_SLACK_TOGGL_API_TOKEN'])

  toggl.configure do |config|
    config.post_channels  = [:test]
    config.post_bot_name  = "toggler"
    config.post_bot_image = ":ghost:"
  end

  toggl.post_message(type)
end
