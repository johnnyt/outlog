require "test_helper"

module Outlog
  class ConsoleLoggerTest < Minitest::Test
    attr_reader :logger

    def setup
      @logger = ::Outlog::ConsoleLogger.new
    end

    def test_logs_to_stdout
      assert_output %r{hello world} do
        logger.info "hello world"
      end
    end
  end
end
