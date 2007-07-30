module Rme2day
    class Post < Record
	attr_writer :body, :kind, :permalink, :icon
        attr_reader :api 

	def self.find_latests(person_id)
	    parse API.get_latests(person_id)
	end

	def self.create(body, tags, icon)
	    parse(API.create_post(body, tags, icon))[0]
	end

	def add_comment(body)
	    Comment.parse API.create_comment(permalink, body)
	end

	def comments
	    @comments || reload_comments
	end

	def reload_comments
	    @comments = Comment.parse API.get_comments(permalink)
	end

	alias reload reload_comments

	def person
	    @person || @person = Person.parse(API.get_person(person_id))[0]
	end

	def to_s
	    #"#{person_id}:  #{body} {#{tags.map{|t|t.to_s}.join(',')}} #{datetime.strftime "%Y-%m-%d %H:%M:%S"}"
	    "#{person_id}:  #{datetime.strftime "%Y-%m-%d %H:%M:%S"}" + "\n" + 
	    "  #{body} " + "\n"+
	    "  {#{tags.map{|t|t.to_s}.join(',')}}"
	end

	def print
	    puts self
	    puts
	    puts comments.map {|c| ' - ' + c.to_s}.join("\r\n")
	end
    end
end
