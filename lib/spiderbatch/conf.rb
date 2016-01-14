require 'json'
require 'singleton'

module SpiderBatch
  class Conf

    attr_accessor :cfile
    attr_accessor :conf

    include Singleton

    # -------------------------------------------------------------------------
    def initialize
      # FIXME: add options to try manually set places...
      cfile_try = [
        'spiderbatch.json',
        '/opt/spiderbatch/spiderbatch.json',
        '/etc/spiderbatch/spiderbatch.json',
        '/etc/spiderbatch.json',
      ]
      cfile_try.insert(1,File.expand_path('~/spiderbatch.json')) if ENV.has_key?'HOME'


      cfile = false
      cfile_try.each do |f|
        if File.exists? f
          cfile = f
          break
        end
      end
      raise "unable to find conf file (tried #{cfile_try.join(',')})" unless cfile

      @cfile = cfile
      reload
    end

    # -------------------------------------------------------------------------
    def reload
      @conf = JSON.parse(File.read(@cfile))
    end

  end
end
