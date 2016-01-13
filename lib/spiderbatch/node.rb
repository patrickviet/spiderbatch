require 'redis'

module SpiderBatch
  class Node

    def initialize
      @conf = SpiderBatch::Conf.instance
    end

    # -------------------------------------------------------------------------
    def single_queue_daemon(queue)
      conf = @conf.conf[queue]
      redis = Redis.new(:host => conf['host'] || '127.0.0.1', :port => (conf['port'] || 6379).to_i, :timeout => 0)

      redis.subscribe(queue) do |on|
        on.message do |channel, msg|
          # FIXME: this doesn't timeout or anything yet.
          IO.popen(conf['command'],'w+') do |p|
            p.puts msg
            p.close_write
            output = ''
            output += p.gets until p.eof?
            puts "OUTPUT OF COMMAND: #{output}"
          end
        end
      end
    end

    # -------------------------------------------------------------------------

  end
end