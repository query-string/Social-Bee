module SocialBee

  class Facebook

    include Koala

    def initialize(p={})
      raise 'Undefined application id' unless @app_id = p[:app_id]
      raise 'Undefined application key' unless @app_key = p[:app_key]
      raise 'Undefined callback url' unless @callback = p[:callback]
    end

    def say_public( message, token )

      Koala::Facebook::OAuth.class_eval do
        def initialize_with_default_settings(*args)
        case args.size
        when 0, 1
          raise "application id and/or secret are not specified in the config" unless @app_id && @app_key
          initialize_without_default_settings(@app_id.to_s, @app_key.to_s, @callback.to_s)
        when 2, 3
          initialize_without_default_settings(*args)
        end
        end
        alias_method_chain :initialize, :default_settings
      end

      Koala::Facebook::GraphAPI.new( token ).put_wall_post( message )
    end

  end

end