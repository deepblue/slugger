module Rme2day
    class Person < Record
	def self.get(person_id)
	    parse(API.get_person(person_id))[0]
	end

	def friends(scope = 'all')
	    @friends || reload_friends(scope)
	end

	def reload_friends(scope)
	    @friends = Person.parse(API.get_friends(person_id, scope))
	end

	def newest_post
	    recent_posts.first
	end

	def recent_posts
	    @recent_posts || reload_recent_posts 
	end

	def reload_recent_posts
	    @recent_posts = Post.parse API.get_latests(person_id)
	end

	alias reload reload_recent_posts

	def to_s
	    person_id
	end
    end
end
