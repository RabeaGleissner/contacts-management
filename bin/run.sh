#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'ui'
require 'app'
require 'store'
App.new(Ui.new($stdin, $stdout), Store.new).run
