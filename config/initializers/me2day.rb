$: << RAILS_ROOT + '/vendor/gems/rme2day/'
require 'rme2day'

file = RAILS_ROOT + '/config/me2day.yml'
raise "설정 파일(#{file})이 필요합니다" unless File.exists?(file)
settings = YAML.load(File.read(RAILS_ROOT + '/config/me2day.yml'))
Rme2day::API.setup(settings['user_id'], settings['user_key'], settings['app_key'])

