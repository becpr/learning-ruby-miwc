require 'twitter'
require 'mailgun'
require 'csv'

# Twitter configuration details
client = Twitter::REST::Client.new do |config|
  config.consumer_key    = yourconsumerkey
  config.consumer_secret = yourconsumersecret
end

# Mailgun configuration details
Mailgun.configure do |config|
  config.api_key = yourapikey
  config.domain  = yoursubdomain
end

# creates csv file of ten twitter search results
CSV.open("my_results.csv", "wb") do |csv|
    client.search("learn to code", :result_type => "recent").take(10).each do |tweet|
        csv.puts [tweet.text, tweet.user.screen_name]
    end
end

# makes file open so it can be attached
my_file = File.open("my_results.csv", "r")

@mailgun = Mailgun()

# add email settings. from should be the mailgun sandbox
parameters = {
  :to => "recipient@domain",
  :subject => "Made it with code!",
  :text => "Here's a list of tweets about learning to code.",
  :from => "you@yourmailgundomain",
  :attachment => my_file
}

@mailgun.messages.send_email(parameters)
