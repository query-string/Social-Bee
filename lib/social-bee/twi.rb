module SocialBee

  class Twi

    include Twitter
    include YAML


    def initialize(p={})

      raise 'Undefined config file' unless @config = YAML.load_file(Rails.root + p[:config])[Rails.env]

      Twitter.configure do |config|
        raise 'Undefined consumer key' unless config.consumer_key = @config['app_key']
        raise 'Undefined consumer secret' unless config.consumer_secret = @config['app_secret']
      end

    end

    def client( token, secret )
      Twitter::Client.new( :oauth_token => token, :oauth_token_secret => secret )
    end


    def say_public( message, token, secret )
      client( token, secret ).update( message )
    end

    def say_private( to, message, token, secret )
      client( token, secret ).direct_message_create( to, message )
    end

    def say_friends( message, token, secret )
      get_friends( token, secret ).each do |itm|
        say_private( itm, message, token, secret )
      end
    end

    def get_friends( token, secret )
      client( token, secret ).follower_ids.ids
    end


  end

end