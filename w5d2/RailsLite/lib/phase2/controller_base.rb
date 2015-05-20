require 'byebug'

module Phase2
  class ControllerBase
    attr_reader :req, :res
    attr_accessor :already_built_response

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response ||= false
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "Already built response!" if already_built_response?
      @res["Location"] = url
      @res.status = 302
      @already_built_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      raise "Already built response!" if already_built_response?
      @res.body = content
      @res.content_type = content_type
      @already_built_response = true
    end
  end
end
