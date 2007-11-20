# Load Setting
SETTINGS_FILE = RAILS_ROOT + '/config/settings.yml'
raise "설정 파일(#{SETTINGS_FILE})이 필요합니다" unless File.exists?(SETTINGS_FILE)
SITE_SETTINGS = YAML.load(File.read(SETTINGS_FILE))


default_parameters = {
  :springnote_user_openid => "스프링노트에 등록된 OpenID를 입력하세요. 예)http://deepblue.myid.net/",
  :springnote_user_key => "다음 주소에서 사용자키를 발급하세요. https://api.openmaru.com/delegate_key/springnote?app_id=0e7d46d9&openid=", 
  
  :index_page_id => "블로그 엔트리 인덱스용으로 사용할 페이지를 스프링노트에 만들고 여기에 페이지 ID를 적어주세요 ex)12345", 
  :side_page_id => "블로그 사이드용으로 사용할 페이지를 스프링노트에 만들고 여기에 페이지 ID를 적어주세요 ex)12346", 
  :property_page_id => "슬러거 데이터 저장용으로 사용할 페이지를 스프링노트에 만들고 여기에 페이지 ID를 적어주세요 ex)12347",
  
  :me2day_user_id => "미투데이 사용자명을 입력하세요. 예)deepblue", 
  :me2day_user_key => "미투데이 사용자키를 입력하세요. 관리 > 계정설정 > me2API 사용자 키에서 얻을 수 있습니다."
}

errors = []
default_parameters.each {|k, v| errors << [k,v] if SITE_SETTINGS[k.to_s].blank? }

unless errors.blank?
  puts "** config/settings.yml 파일에서 아래 필드들을 확인하기 바랍니다.\n\n"
  errors.each {|val| puts "===> #{val[0]}: #{val[1]}" }
  puts
  raise
else
  puts "** config/settings.yml loaded successfully."
end


# intialize Springnote
require 'springnote'

SPRINGNOTE_APP_KEY = '39115f59a24e96b651a7cf36f086d3ef26ab7c9e'
Springnote::Base.configuration.set :app_key => SPRINGNOTE_APP_KEY, 
  :user_openid => Site.springnote_user_openid,
  :user_key    => Site.springnote_user_key
# ActiveResource::Base.logger = Logger.new STDOUT


# intialize Me2day
$: << RAILS_ROOT + '/vendor/gems/rme2day/'
require 'rme2day'

ME2DAY_APP_KEY = '3fae47687ec6c3f453201a9130dc88c4'