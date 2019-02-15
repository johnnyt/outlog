module Outlog
  class JsonLogger < BaseLogger
    def output hash
      $stdout.puts hash.to_json
      $stdout.flush
    end
  end
end
