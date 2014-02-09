require "twitter"

# Authentication details from twitter

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = yourconsumerkey
  config.consumer_secret = yourconsumersecret
end

# Search for learn to code and return 
# 10 most recent results

client.search("learn to code", :result_type =>"recent").take(10).each do |tweet|
    puts tweet.text
end; nil
