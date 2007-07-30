require File.dirname(__FILE__) + '/../lib/rme2day'
require File.dirname(__FILE__) + '/post_xml'

module CheckResult
    def check_result(result, options)
	doc = Hpricot result
	doc.should be_an_instance_of(Hpricot::Doc) 

	options.each do |k, v|
	   doc.at(k.to_s).inner_html.should == v if v.class == String
	   doc.at(k.to_s).inner_html.should =~ v if v.class == Regexp
	end
        return doc
    end
end

describe Rme2day::API, "with get_lastest" do
    include PostXml
    include CheckResult

    it "should build a appropriate url for get" do
	url = Rme2day::API.latests_post_url 'codian'
	url.should == 'http://me2day.net/api/get_latests/codian.xml'
    end

    it "should get real xml" do
	result = Rme2day::API.do_open('http://me2day.net/api/get_latests/codian.xml')
	check_result(result, {:id => 'codian'})
    end

    it "should get a latest posts of a user" do
	Rme2day::API.should_receive(:do_open).and_return(generate_simple_posts_xml)
	result = Rme2day::API.get_latests 'codian'
    end
end


