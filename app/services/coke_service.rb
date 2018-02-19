class CokeService

  ENDPOINT = "https://devtestapiapp.herokuapp.com/tweets.json"

  attr_accessor :resource

  def get_latest
    @resource = HTTP.get(ENDPOINT)

    return false if http_error? || service_error?

    tweets = JSON.parse(@resource.body)
    tweets.each do |tweet|
      Tweet.create(user_id: tweet["id"].to_i,
        user_handle: tweet["user_handle"],
        followers: tweet["followers"].to_i,
        message: tweet["message"],
        sentiment: tweet["sentiment"].to_f,
        published: DateTime.parse(tweet["created_at"]))
    end
    true
  end

  def http_error?
    @resource.status != 200
  end

  def service_error?
    json = JSON.parse(@resource.body)
    json.respond_to?(:has_key?) && json.has_key?("error")
  end

end
