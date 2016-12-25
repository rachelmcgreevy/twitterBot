require 'twitter'

begin

	config = {
		consumer_key: "your_consumer_key",
		consumer_secret: "your_consumer_secret",
		access_token: "your_access_token",
		access_token_secret: "your_access_token_secret"
	}

	rClient = Twitter::REST::Client.new config
	sClient = Twitter::Streaming::Client.new(config)

	topics = ["#hashtag1", "#hashtag2", "#hashtag3"]
	sClient.filter(track: topics.join(","), lang: "en") do |object|
			if object.is_a?(Twitter::Tweet) and object.media? and not object.retweeted_tweet? and not object.urls?
				rClient.fav object
			end
	end
rescue
	puts 'error occured, waiting 5 secs'
	sleep 300
end
