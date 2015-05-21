require 'webrick'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/session'
require_relative '../lib/params'
require_relative '../lib/flash'

class Cat
  attr_reader :name, :owner

  def self.all
    @cat ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name, @owner = params["name"], params["owner"]
  end

  def save
    return false unless @name.present? && @owner.present?

    Cat.all << self
    true
  end

  def inspect
    { name: name, owner: owner }.inspect
  end
end

class CatsController < Controllable::ControllerBase
  # def show_flash_now
  #   @cat = Cat.new
  #   @cats = Cat.all
  #   flash.now[:errors] = ["Flash.now!"]
  #   render :index
  # end

  def go
    @cat = Cat.new
    flash.now[:errors] = ["Flash now message!"]
    flash[:errors] = ["Flash message!"]
    render :new
  end

  def stop
    @cat = Cat.new
    # redirect_to("/cats")
  end

end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  case [req.request_method, req.path]
  when ['GET', '/cats']
    CatsController.new(req, res).stop
  when ['GET', '/cats/new']
    CatsController.new(req, res).go
  end
end

trap('INT') { server.shutdown }
server.start
