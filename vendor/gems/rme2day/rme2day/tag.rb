module Rme2day
    class Tag
	attr_accessor :name, :url
	def initialize(name, url)
	    @name = name
	    @url = url
	end

	def to_s
	    @name
	end
    end
end
