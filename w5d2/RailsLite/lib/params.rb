require 'uri'
require 'byebug'

module Controllable
  class Params
    def initialize(req, route_params = {})
      @params = route_params
      @params.merge!(parse_www_encoded_form(req.query_string)) if req.query_string
      @params.merge!(parse_www_encoded_form(req.body)) if req.body
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # user[address][street]=main&user[address][zip]=89436
    # => [["user[address][street]", "main"], ["user[address][zip]", "89436"]]
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      www_array = URI::decode_www_form(www_encoded_form)
      nested_hash = {}
      # to merge body and query_string (in case of conflicting keys):
      # nested_hash = @params
      # otherwise body keys overwrite query_string keys

      www_array.each do |pair|
        keys = parse_key(pair.first)
        val = pair.last
        current = nested_hash
        keys.each_with_index do |key, idx|
          if idx == keys.length - 1
            current[key] = val
          else
            current[key] ||= {}
            current = current[key]
          end
        end
      end
      nested_hash
    end

    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      components = key.split(/\]\[|\[|\]/)
      components.map do |el|
        el.scan(/\w+/).first
      end
    end
  end
end
