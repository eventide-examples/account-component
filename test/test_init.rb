ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'entity_projection/fixtures'
require 'messaging/fixtures'

require 'pp'

require 'account_component/controls'

module AccountComponent; end
include AccountComponent
