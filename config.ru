# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
use Rack::NoWWW
use Rack::Deflater
use Rack::Pjax
run Rails.application
