module Outlog
  class BaseLogger
    def level
      return @level if defined? @level
      self.level = ENV["LOG_LEVEL"] || "info"
      @level
    end

    def level_name lookup=level
      ::Logger::SEV_LABEL[lookup]
    end

    def level_symbol
      level_name.downcase.to_sym
    end

    def level= new_level
      if new_level.is_a? Integer
        @level = new_level
      else
        lookup = new_level.to_s.upcase
        @level = ::Logger::SEV_LABEL.index lookup
      end
    end

    def debug message, hash={}
      add ::Logger::DEBUG, message, hash
    end

    def info message, hash={}
      add ::Logger::INFO, message, hash
    end

    def warn message, hash={}
      add ::Logger::WARN, message, hash
    end

    def error message, hash={}
      add ::Logger::ERROR, message, hash
    end

    def fatal message, hash={}
      add ::Logger::FATAL, message, hash
    end

    private

    def output hash
      puts hash
    end

    def add severity, message, hash
      severity = severity.nil? ? ::Logger::UNKNOWN : severity.to_i
      return true if severity < level

      hash = hash.dup
      loc = caller_locations(2, 1).first
      hash[:filename] = "%s:%d" % [loc.path, loc.lineno]

      severity_name = level_name severity

      hash[:level] = severity_name
      hash[:message] = message

      log_hash = generate_log_hash hash

      output log_hash
    end

    def generate_log_hash input={}
      #hash = input.merge RequestStore.store
      hash = input
      hash.merge! ts: Time.now.to_f,
                  environment: environment,
                  hostname: hostname,
                  pid: pid
    end

    def environment
      @environment ||= ENV["RACK_ENV"] || ENV["APP_ENV"] || "development"
    end

    def hostname
      @hostname ||= Socket.gethostname
    end

    def pid
      @pid ||= Process.pid
    end
  end
end
