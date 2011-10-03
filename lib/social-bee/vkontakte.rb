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


    def say_public( message, token )
      @app.access_token = token
      @app.wall.post( :message => CGI::escape(message) )
    end


  end

end