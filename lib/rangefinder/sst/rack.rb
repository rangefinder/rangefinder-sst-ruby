module Rangefinder
  class SST
    class Rack
      def initialize(app, config = {})
        @app = app
        @autoinject = config[:autoinject].nil? ? true : config[:autoinject]
        # Pass config on to the SST instance.
        @sst = Rangefinder::SST.new config
      end

      def code
        @sst.code
      end

      def call(env)
        env['rangefinder'] = self
        @sst.track(
          :page => env['REQUEST_URI'],
          :referrer => env['HTTP_REFERER'],
          :user_agent => env['HTTP_USER_AGENT'],
          :ipv4 => env['REMOTE_ADDR']
        )
        unless @autoinject
          # Don't do all the work if you don't need to.
          return @app.call(env)
        else
          status, headers, body = @app.call(env)
          # If there's a content-type and it doesn't have "text/html" in it then just return
          if !headers['Content-Type'].nil? && headers['Content-Type'].index('text/html') == false
            return [status, headers, body]
          end
          # Build a new response
          response = ::Rack::Response.new([], status, headers)
          body.each do |b|
            # Rebuild the response body part by part
            body_close = b.rindex(/<\/body[^>]*>/i)
            unless body_close.nil?
              # Insert the code before the closing body tag
              b.insert body_close, "\n"+@sst.code
            end
            response.write b
          end
          response.finish
        end
      end#call(env)
    end#Rack
  end#SST
end#Rangefinder
