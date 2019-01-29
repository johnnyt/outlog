module Outlog
  class ConsoleLogger < BaseLogger
    # Mapping of color/style names to ANSI control values
    CODEMAP = {
      normal: 0,
      bold: 1,
      black: 30,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      magenta: 35,
      cyan: 36,
      white: 37
    }

    # Map of log levels to colors
    LEVELMAP = {
      "FATAL" => :red,
      "ERROR" => :red,
      "WARN" => :yellow,
      "INFO" => :green, # default color
      "DEBUG" => :normal
    }

    def output hash
      arr = [hash[:message]]
      hash.each_pair { |k,v|
        next if %i[ ts level environment hostname pid message ].include? k
        arr << " #{k}="
        arr << JSON.dump(v)
      }
      color = LEVELMAP[hash[:level]] || :green

      arr.unshift "\e[#{CODEMAP[color]}m"
      arr << "\e[#{CODEMAP[:normal]}m"

      puts arr.join
      $stdout.flush
    end
  end
end
