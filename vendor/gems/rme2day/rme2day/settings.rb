module Rme2day
    class Settings < Record
	def self.get(person_id)
	    parse(API.get_settings(person_id))[0]
	end
    end
end


