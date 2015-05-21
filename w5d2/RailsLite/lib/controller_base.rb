require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './params'
require_relative './flash'
require 'byebug'

module Controllable
  class ControllerBase
    attr_reader :req, :res
    attr_accessor :already_built_response, :params

    def initialize(req, res, route_params = {})
      @req = req
      @res = res
      @params = Params.new(req, route_params)
    end

    def already_built_response?
      @already_built_response ||= false
    end

    def invoke_action(name)
      self.send(name)
      render name unless already_built_response?
    end

    def flash
      @flash ||= Flash.new(@req)
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "Already built response!" if already_built_response?
      @res["Location"] = url
      @res.status = 302
      @already_built_response = true
      session.store_session(@res)
      flash.store_flash(@res)
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      raise "Already built response!" if already_built_response?
      @res.body = content
      @res.content_type = content_type
      @already_built_response = true
      session.store_session(@res)
      flash.store_flash(@res)
    end

    def render(template_name)
      file_contents = File.read("views/#{self.class.to_s.underscore}/#{template_name}.html.erb")
      erb_template = ERB.new(file_contents).result(binding)
      render_content(erb_template, "text/html")
    end

    def session
      @session ||= Session.new(@req)
    end
  end
end
