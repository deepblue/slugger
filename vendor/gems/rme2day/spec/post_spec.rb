require File.dirname(__FILE__) + '/../lib/rme2day'
require File.dirname(__FILE__) + '/post_xml'

require File.dirname(__FILE__) + '/setup'  # make your own setup.rb


describe Rme2day::Post, "with find_latests" do
    include PostXml

    before(:each) do 
        Rme2day::API.should_receive(:do_open).and_return(generate_simple_posts_xml)
	@posts = Rme2day::Post.find_latests('codian')
	@post = @posts[0]
    end

    it "should return Post objects" do
	@post.should be_an_instance_of(Rme2day::Post)
    end

    it "should get attributes thorouth special parsing : person_id, datetime " do
	@post.person_id.should == 'codian'
	@post.datetime.should == Time.gm(2007, 6, 30, 13, 3, 34)
    end

    it "should get attributes through method_missing : kind, body, permalink" do
	@post.body.should =~ /body1/
	@post.kind.should == 'think'
	@post.permalink.should =~ /me2day.net/
    end

    it "should raise error for unknown tag element" do
	lambda{@post.xyz.should == 'there is no tag xyz'}.should raise_error(NoMethodError)
    end
end


describe Rme2day::Post, "with comments" do
    before(:each) do 
	@post = Rme2day::Post.new
	@post.stub!(:permalink).and_return("http://me2day.net/ruby2day/2007/05/16#21:34:48")
	@comments = @post.comments
	@comment = @comments[0]
    end

    it "should get comments" do
	@comment.should be_an_instance_of(Rme2day::Comment)
    end

    it "should get comment attributes" do
	@comment.body.should =~ /devil/
	@comment.person_id.should == 'zendy'
    end

end

describe Rme2day::Post, "with Person" do
    before(:each) do 
	@post = Rme2day::Post.new
	@post.stub!(:person_id).and_return("ikspres")
	@person = @post.person
    end

    it "should get Person object" do
	@person.should be_an_instance_of(Rme2day::Person)
    end
end



describe Rme2day::Post, "with create" do
    include PostXml

    before(:each) do 
	@body = 'body1'
	@tags = 'tag1 tag2'
	@icon = 1
    end

    it "should make right url and parameters" do
	params = Rme2day::API.create_post_params(@body, @tags, @icon)
	params.should == '?post[body]=body1&post[tags]=tag1%20tag2&post[icon]=1'
    end
    it "should create and return result Post object" do
	Rme2day::API.should_receive(:do_open).and_return(create_post_result_xml)
	post = Rme2day::Post.create(@body, @tags, @icon)
	post.should be_an_instance_of(Rme2day::Post)
    end

end
