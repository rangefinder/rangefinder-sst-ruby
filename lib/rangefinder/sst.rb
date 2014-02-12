require 'rangefinder/sst/version'
require 'addressable/uri'

module Rangefinder
  class SST
    DEFAULT_ENDPOINT = 'rangefinderapp.com'
    DEFAULT_PORT     = 8001
    DEFAULT_SCRIPT   = 'rangefinderapp.com/track1.js';
    
    attr_accessor :site_key, :site_id,
                  :endpoint, :port, :script
    attr_reader :server_id
    
    @@rand = Proc.new { Kernel.rand 1000000 }
    class << self
      def rand; @@rand; end
      # Change the random server ID generator.
      # eg. Rangefinder::SST.rand = Proc.new { MySpecial.rand }
      def rand=(r) @@rand = r; end
    end
    
    def initialize(opts = {})
      @site_key = opts[:site_key] || ''
      @site_id  = opts[:site_id]  || 0
      @server_id = 0
      @socket = nil
      
      @script = opts[:script] || DEFAULT_SCRIPT
      @endpoint = opts[:endpoint] || DEFAULT_ENDPOINT
      @port = opts[:port] || DEFAULT_PORT
    end
    
    def track(visit)
      connect if @socket.nil?
      
      @id = self.class.rand.call
      packet = 'track:'+Addressable::URI.form_encode(
        :key => @site_key,
        :page => visit[:page],
        :referrer => visit[:referrer],
        :user_agent => visit[:user_agent],
        :ipv4 => visit[:ipv4],
        :time => Time.now.utc.to_i,
        :id => @id
      )+"\n"
      
      if packet.length < 1499
        @socket.send packet, 0
      else
        @id = -2 # Too long
      end
      return @id
    end
    def connect
      @socket = UDPSocket.new
      @socket.connect(@endpoint, @port)
    end
  end
end
