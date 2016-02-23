require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib/controller.rb')
use Rack::Static, urls: ['/css', '/js', '/img', '/fonts'], root: 'lib/public'

run SlowFood
