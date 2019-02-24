require "test_helper"

module Outlog
  class JsonLoggerTest < Minitest::Test
    attr_reader :logger

    def setup
      @logger = ::Outlog::JsonLogger.new
    end

    def test_logs_to_stdout
      assert_output %r{hello world} do
        logger.info "hello world"
      end
    end

    def test_includes_line_number
      assert_output %r(#{File.basename __FILE__}:\d+) do
        logger.info "hello world"
      end
    end
  end
end
