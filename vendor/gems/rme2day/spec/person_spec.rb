require File.dirname(__FILE__) + '/../lib/rme2day'

describe Rme2day::Person, "with get" do
  it "should create and read person info" do
    me = Rme2day::Person.get('ikspres')
    me.should be_an_instance_of(Rme2day::Person)
  end
end

describe Rme2day::Person, "with friends" do
    it "should return right get url" do
	url = Rme2day::API.get_friends_url('ikspres', 'all')
	url.should == 'http://me2day.net/api/get_friends/ikspres.xml?scope=all'
    end


    it "should get array of Person objects" do
	me = Rme2day::Person.get('ikspres')
	friends = me.friends
	friends.should be_an_instance_of(Array)
	friends[0].should be_an_instance_of(Rme2day::Person)
    end
end
