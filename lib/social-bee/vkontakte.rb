module SocialBee

  class Vkontakte

    include VK

    def initialize(p={})
      raise 'Undefined application id' unless @app_id = p[:app_id]
      raise 'Undefined application key' unless @app_key = p[:app_key]
    end

    def say_public( message, token )
      app = VK::Standalone.new :app_id => @app_id, :app_secret => @app_key
      app.access_token = token
      app.wall.post( :message => CGI::escape(message) )
    end

  end

end