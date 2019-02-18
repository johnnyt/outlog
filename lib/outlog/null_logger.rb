module Outlog
  class NullLogger < BaseLogger
    def output _hash
      # no-op
    end
  end
end
