require File.dirname(__FILE__) + '/../lib/springnote'

describe Springnote::Configuration do
  before(:each) do
    @configuration = Springnote::Configuration.new
  end
  
  it "app_id를 설정하지 않으면 에러" do
    lambda { @configuration.app_id }.should raise_error(Springnote::MissingConfiguration)
    @configuration.app_id = 'app_id'
    @configuration.app_id.should == 'app_id'
  end

  it "app_key를 설정하지 않으면 에러" do
    lambda { @configuration.app_key }.should raise_error(Springnote::MissingConfiguration)
    @configuration.app_key = 'app_key'
    @configuration.app_key.should == 'app_key'
  end
  
  it "password를 얻을 수 있다" do
    set_test_auth
    
    password = @configuration.password
    password.should_not be_empty
    parsed = CGI.unescape(password).split(',')
    parsed.length.should == 4
  end
  
  it "passwd는 매번 바뀐다" do
    set_test_auth
    @configuration.password.should_not == @configuration.password
  end
  
  it "site를 반환한다" do
    set_test_auth
    @configuration.site.should match(/http:\/\/(.*?):(.*?)@api.springnote.com\//)
  end
  
  def set_test_auth
    @configuration.app_id = 'app_id'
    @configuration.app_key = 'app_key'
    @configuration.user_key = 'user_key'
    @configuration.user_open_id = 'http://user.myid.net/'
  end
end