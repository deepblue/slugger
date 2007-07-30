SETTINGS_FILE = RAILS_ROOT + '/config/settings.yml'
raise "설정 파일(#{SETTINGS_FILE})이 필요합니다" unless File.exists?(SETTINGS_FILE)
SITE_SETTINGS = YAML.load(File.read(SETTINGS_FILE))

require 'springnote'
Springnote::Base.configuration.load RAILS_ROOT + '/config/springnote.yml'

$: << RAILS_ROOT + '/vendor/gems/rme2day/'
require 'rme2day'
settings = YAML.load(File.read(RAILS_ROOT + '/config/me2day.yml'))
Rme2day::API.setup(settings['user_id'], settings['user_key'], settings['app_key'])

ActiveResource::Base.logger = Logger.new STDOUT