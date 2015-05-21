module Controllable
  class Flash
    def initialize(req)
      rails_cookie = req.cookies.find do |cookie|
        cookie if cookie.name == '_rails_lite_flash'
      end
      @flash_now = (rails_cookie ? JSON.parse(rails_cookie.value) : {})
      @flash = {} #(rails_cookie ? rails_cookie.flash_now : {})
    end

    def [](message_key)
      @flash_now[message_key]
    end

    def []=(message_key, message)
      @flash[message_key] = message
    end

    def now
      @flash_now
    end

    def store_flash(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_flash', @flash.to_json)
    end
  end
end
