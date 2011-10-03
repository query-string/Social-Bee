module SocialBee

  class Twi

    include Twitter
    include YAML


    def initialize(p={})
      raise 'Undefined config file' unless @config = YAML.load_file(Rails.root + p[:config])[Rails.env]
    end


    def say_public( message, token, secret )
      Twitter.configure do |config|
        raise 'Undefined consumer key' unless config.consumer_key = @config['app_key']
        raise 'Undefined consumer secret' unless config.consumer_secret = @config['app_secret']
        raise 'Undefined user token' unless config.oauth_token = token
        raise 'Undefined user secret' unless config.oauth_token_secret = secret
      end
      Twitter.update( message )
    end


  end

end