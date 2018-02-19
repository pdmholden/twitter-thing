class CokeService

  ENDPOINT = "https://devtestapiapp.herokuapp.com/tweets.json"

  attr_accessor :resource

  def get_latest
    @resource = nil
    @resource = HTTP.get(ENDPOINT)

    return if http_error? || service_error?

    body = JSON.parse(@resource.body)
  end

  def http_error?
    @resource.status != 200
  end

  def service_error?
    json = JSON.parse(@resource.body)
    json.respond_to?(:has_key?) && json.has_key?("error")
  end

end
