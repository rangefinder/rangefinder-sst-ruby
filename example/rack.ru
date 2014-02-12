require 'rubygems'
require 'sinatra'
require 'rangefinder/sst'
require 'rangefinder/sst/rack'

class MyApp < Sinatra::Base
  get '/' do
    '<html><body>Hello world!</body></html>'
  end
end

use Rangefinder::SST::Rack, :site_id => 4
run MyApp
