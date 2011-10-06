module SocialBee

  class Facebook

    include Koala
    include YAML


    def initialize(p={})

      raise 'Undefined config file' unless config = YAML.load_file(Rails.root + p[:config])[Rails.env]
      raise 'Undefined application id' unless @app_id = config['app_id']
      raise 'Undefined application key' unless @app_key = config['app_key']
      raise 'Undefined callback url' unless @callback = config['callback_url']

      Koala::Facebook::OAuth.class_eval do
        def initialize_with_default_settings(*args)
        case args.size
        when 0, 1
          raise "Application id and/or secret are not specified in the config" unless @app_id && @app_key
          initialize_without_default_settings(@app_id.to_s, @app_key.to_s, @callback.to_s)
        when 2, 3
          initialize_without_default_settings(*args)
        end
        end
        alias_method_chain :initialize, :default_settings
      end

    end

    def client( token )
      Koala::Facebook::API.new( token )
    end


    def say_public( message, token )
      client( token ).put_wall_post( message )
    end

    def say_private( to, message, token )
      client( token ).put_object( to, 'inbox', :message => message )
    end

    def say_friends( message, token )
      get_friends( token ).each do |itm|
        say_private( itm, message, token )
      end
    end

    def get_friends( token )
      arr = []
      client( token ).get_connections('me', 'friends').each do |itm|
        arr.push itm['id']
      end
      arr
    end


  end

end