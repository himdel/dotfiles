gem 'pry'
gem 'pry-byebug'

def describe(dir)
  fulldir = File.expand_path("../#{dir}", __dir__)
  git = `cd "#{fulldir}" ; git describe --all`
  $stderr.puts "Using #{dir} @ #{git}"
end

describe('.')

describe('plugins/manageiq-ui-classic')
override_gem 'manageiq-ui-classic', :path => File.expand_path('../plugins/manageiq-ui-classic', __dir__)

#describe('plugins/miq_v2v_ui_plugin')
#override_gem 'miq_v2v_ui', :path => File.expand_path('../plugins/miq_v2v_ui_plugin', __dir__)

#describe('plugins/manageiq-api')
#override_gem 'manageiq-api', :path => File.expand_path('../plugins/manageiq-api', __dir__)
