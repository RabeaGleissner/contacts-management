#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'contact'
require 'ui'
require 'app'
App.new(Ui.new($stdin, $stdout)).run
