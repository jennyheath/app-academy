require_relative '../phase6/controller_base'
require_relative './flash'

module PhaseBonus
  class ControllerBase < Phase6::ControllerBase
    def redirect_to(url)
      super
      store_flash(@res)
    end

    # def render_content(content, content_type)
    #   super
    #   show_flash
    # end

    def flash
      @flash ||= Flash.new(@req)#.show_flash
    end
  end
end
