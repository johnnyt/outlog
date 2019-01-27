module Outlog
  class JsonLogger < BaseLogger
    def output hash
      puts hash.to_json
    end
  end
end
