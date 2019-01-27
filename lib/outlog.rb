require "outlog/version"

require "logger"
require "json"
require "socket"

require "outlog/base_logger"
require "outlog/console_logger"
require "outlog/json_logger"

module Outlog
  class Error < StandardError; end

  module_function

  def info message

  end

  def logger
    @logger ||= create_logger
  end

  def logger= new_logger
    @logger = new_logger
  end

  def create_logger
    environment = ENV["RACK_ENV"] || ENV["APP_ENV"] || "development"

    case environment
    when "development"
      ::Outlog::ConsoleLogger.new
    else
      ::Outlog::JsonLogger.new
    end
  end
end
