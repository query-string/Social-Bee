module SocialBee

  class Vkontakte

    include VK
    include YAML


    def initialize(p={})

      raise 'Undefined config file' unless config = YAML.load_file(Rails.root + p[:config])[Rails.env]
      raise 'Undefined application id' unless app_id = config['app_id']
      raise 'Undefined application key' unless app_key = config['app_key']

      @app = VK::Standalone.new :app_id => app_id, :app_secret => app_key

    end

    def client( token )
      @app.access_token = token
      @app
    end


    def say_public( message, token )
      client( token ).wall.post( :message => CGI::escape(message) )
    end

    def say_private( to, message, token )
      client( token ).messages.send( :uid => to, :message => message )
    end

    def say_friends( message, token )
      get_friends(token).each do |itm|
        say_private( itm, message, token )
      end
    end

    def get_friends( token )
      client( token ).friends.get
    end


  end

end