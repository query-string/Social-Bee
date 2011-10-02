module SocialBee

  class Twi

    include Twitter

    def initialize(p={})
      raise 'Undefined application key' unless @app_key = p[:app_key]
      raise 'Undefined application secret' unless @app_secret = p[:app_secret]
    end

    def say_public( message, token, secret )
      Twitter.configure do |config|
        config.consumer_key = @app_key
        config.consumer_secret = @app_secret
        config.oauth_token = token
        config.oauth_token_secret = secret
      end
      Twitter.update( message )
    end

  end

end