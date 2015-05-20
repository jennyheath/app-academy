require 'uri'
require 'byebug'

module PhaseBonus
  class Flash
    def initialize(req)
      rails_cookie = req.cookies.each do |cookie|
        cookie if cookie.name == '_rails_lite_flash'
      end
      @flash = (rails_cookie ? rails_cookie.flash : {})
      # @flash_now = (rails_cookie ? rails_cookie.flash_now : {})
    end

    def [](message_key)
      # debugger
      @flash[message_key]
    end

    def []=(message_key, message)
      debugger
      @flash[message_key] = message
    end

    def now
      @flash_now
    end
    # def now[](message_key)
    #   @flash_now[message_key]
    # end
    #
    # def now[]=(message_key, message)
    #   @flash_now[message_key] = message
    # end
    def store_flash(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_flash', @flash.to_json)
    end

    def show_flash
      @flash.values
    end
  end
end
