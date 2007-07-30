module Rme2day
    class Comment < Record
#	def self.parse(data)
#	    doc = Hpricot data
#	    doc.to_s
#	end

	def person
	    @person || @person = Person.parse(API.get_person(person_id))[0]
	end

	def to_s
	    "#{body} #{datetime.strftime "%Y-%m-%d %H:%M:%S"} #{person_id}:  "
	end
    end
end
