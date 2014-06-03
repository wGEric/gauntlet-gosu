require 'rubygems'
require 'bundler/setup'

require 'gosu'
require 'chingu'
require 'tmx'
require 'pathname'

require 'pry'
require 'pry-debugger'

GAUNTLET_ROOT = File.dirname(File.expand_path($0))

require_all "#{GAUNTLET_ROOT}/lib/traits"
require_all "#{GAUNTLET_ROOT}/lib/objects"
require_all "#{GAUNTLET_ROOT}/lib/map"
require_all "#{GAUNTLET_ROOT}/lib/states"
require_all "#{GAUNTLET_ROOT}/lib/windows"

MainGame.new.show
