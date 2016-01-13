require 'redis'

module SpiderBatch
  class CLI

    def initialize
      @conf = SpiderBatch::Conf.instance
    end

    def publish_stdin(queue)
      conf = @conf.conf[queue]
      redis = Redis.new(:host => conf['host'] || '127.0.0.1', :port => (conf['port'] || 6379).to_i)

      puts "Reading STDIN..."
      msg = STDIN.read

      puts "I will publish #{msg} to queue #{queue}"

      redis.publish queue, msg
    end
  end
end
