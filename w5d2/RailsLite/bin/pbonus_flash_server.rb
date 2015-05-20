require 'webrick'
require_relative '../lib/bonus/controller_base'
require_relative '../lib/bonus/flash'

class ErrorCatsController < PhaseBonus::ControllerBase
  def go
    flash[:errors] = ["Print this error!"]
    render :new
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  ErrorCatsController.new(req, res).go
end

trap('INT') { server.shutdown }
server.start
