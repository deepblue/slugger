require File.dirname(__FILE__) + '/../lib/rme2day'
require File.dirname(__FILE__) + '/settings_xml'

require File.dirname(__FILE__) + '/setup' # make your own setup.rb




describe Rme2day::Settings, "with get" do
  include SettingsXml

  before(:each) do
    Rme2day::API.should_receive(:do_open).and_return(simple_settings_xml)
    @me = Rme2day::Settings.get('ikspres')

  end

  it "should get a Settings object" do
    @me.should be_an_instance_of(Rme2day::Settings)
  end

  it "should have attributes mytags and decription" do
    @me.mytags.should == 'tag1 tag2'
    @me.description.should == 'description1'
  end

end

