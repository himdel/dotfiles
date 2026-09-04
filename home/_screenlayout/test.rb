#!/usr/bin/env ruby
require 'xrandr'

outputs = Xrandr::Control.new.outputs.select do |o|
  o.connected && o.current
end

primary = outputs.find do |o|
  o.primary
end

p primary
