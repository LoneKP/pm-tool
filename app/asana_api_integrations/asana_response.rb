class AsanaResponse
    def initialize(http_response:)
      @http_response = http_response
      raise AsanaInvalidToken if token_expired?
      raise AsanaBadResponse unless valid_response
    end
  
    def data
      parsed_response.dig("data")
    end
  
    private
  
    attr_reader :http_response
  
    def parsed_response
      http_response.parsed_response
    end
  
    def valid_response
      parsed_response.dig("data").present?
    end
  
    def token_expired?
      if parsed_response.dig("errors") == [{ "message" => "The bearer token has expired. If you have a refresh token, please use it to request a new bearer token, otherwise allow the user to re-authenticate.", "help" => "For more information on API status codes and how to handle them, read the docs on errors: https://asana.com/developers/documentation/getting-started/errors" }]
        true
      else
        false
      end
    end
  end
  
  class AsanaBadResponse < StandardError
  end
  
  class AsanaInvalidToken < StandardError
    attr_reader :http_response
  
    def initialize(http_response:)
      @http_response = http_response
    end
  
    begin
      raise AsanaInvalidToken.new(http_response), "Invalid token"
    rescue AsanaInvalidToken => e
      puts e.message # => "a message"
      puts e.http_response # => "an object"
    end
  end
  