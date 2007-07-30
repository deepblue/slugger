SETTINGS_FILE = RAILS_ROOT + '/config/settings.yml'
raise "설정 파일(#{SETTINGS_FILE})이 필요합니다" unless File.exists?(SETTINGS_FILE)
SITE_SETTINGS = YAML.load(File.read(SETTINGS_FILE))
