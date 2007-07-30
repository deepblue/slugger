require 'springnote'
file = RAILS_ROOT + '/config/springnote.yml'
raise "설정 파일(#{file})이 필요합니다" unless File.exists?(file)
Springnote::Base.configuration.load file
# ActiveResource::Base.logger = Logger.new STDOUT