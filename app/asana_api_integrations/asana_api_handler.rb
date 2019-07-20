
class AsanaApiHandler
  def initialize(http_response:)
    @http_response = http_response
    raise AsanaInvalidTokenError if token_expired?
    raise AsanaTokenDoesNotExistError if http_response === nil
  end

  class AsanaInvalidTokenError < StandardError
    "Token is invalid"
  end

  class AsanaTokenDoesNotExistError < StandardError
    "Something is wrong with the integration"
  end

  def data
    http_response.parsed_response.dig("data")
  end

  def token_expired?
    if parsed_response.dig("errors") == [{ "message" => "The bearer token has expired. If you have a refresh token, please use it to request a new bearer token, otherwise allow the user to re-authenticate.", "help" => "For more information on API status codes and how to handle them, read the docs on errors: https://asana.com/developers/documentation/getting-started/errors" }]
      true
    else
      false
    end
  end

  private

  attr_reader :http_response
end
