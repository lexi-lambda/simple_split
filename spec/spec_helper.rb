require 'bundler/setup'
Bundler.setup

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'simple_split'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
