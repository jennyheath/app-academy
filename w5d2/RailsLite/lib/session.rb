require 'json'
require 'webrick'
require 'byebug'

module Controllable
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      rails_cookie = req.cookies.find do |cookie|
        cookie if cookie.name == '_rails_lite_app'
      end
      @session_cookie = (rails_cookie ? JSON.parse(rails_cookie.value) : {})
    end

    def [](key)
      @session_cookie[key]
    end

    def []=(key, val)
      @session_cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @session_cookie.to_json)
      self
    end
  end
end
