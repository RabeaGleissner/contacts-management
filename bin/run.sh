#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'ui'
require 'app'
require 'printer'
App.new(Ui.new($stdin, $stdout)).run
