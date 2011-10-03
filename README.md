#social-bee
Simple messaging wrapper for Facebook, Twitter, Vkontakte


## Installation
`gem install social-bee`


## Usage Example

```.ruby
# message_controller.rb

class MessageController < ApplicationController
    def create
        SocialBee::Facebook.new( :config => "config/social/facebook.yml" ).say_public( 'Beep!', params[:user_token] )
    end
end

```

```.yml
# config/social/facebook.yml

development:
    app_id: [YOUR APP ID]
    app_key: [YOUR APP KEY]
    callback_url: http://localhost:3000/
production:
    app_id: [YOUR APP ID]
    app_key: [YOUR APP KEY]
    callback_url: http://www.host.name
```