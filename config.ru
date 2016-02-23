require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib/controller.rb')
use Rack::Static, urls: ['/css', '/js', '/img', '/fonts'], root: 'assets'
config.serve_static_assets = true

run SlowFood
