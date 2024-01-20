#!/usr/bin/env ruby
ENV['RAILS_ENV'] = 'development'

require '../manageiq/config/environment'

#in miq-ui-classic ls | grep "controller.rb" | cut -d '.' -f 1
all_controllers = `ls app/controllers/ | grep "controller.rb" | cut -d '.' -f1`.split("\n")

whitelist = []

all_controllers.each do |controller_name|
  break if controller_name == "oauth_sessions_controller"
  controller = controller_name.classify.constantize
  buttons = controller.constants.select{|x| x.to_s.include?("ALLOWED_ACTIONS")}
  break unless buttons.present?
  buttons.each do |button|
    whitelist.concat(controller.const_get(button).keys)
  end
end
whitelist.sort.uniq.each { |item|  puts item }
