$: << RAILS_ROOT + '/vendor/gems/rme2day/'
require 'rme2day'

M2DAY_CONFIGURATION_FILE = RAILS_ROOT + '/config/me2day.yml'
raise "설정 파일(#{file})이 필요합니다" unless File.exists?(M2DAY_CONFIGURATION_FILE)
