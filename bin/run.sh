#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'ui'
require 'app'
require 'store'
require 'menu'
App.new(Menu.new, Ui.new($stdin, $stdout), Store.new).run
