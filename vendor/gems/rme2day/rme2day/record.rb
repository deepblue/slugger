module Rme2day
    class Record
	attr_accessor :person_id, :datetime, :tags

	def initialize(doc=nil)
	    @doc = doc
	end

	def self.parse(data)
	    doc = Hpricot data

	    # this part is implemented very generally,
	    # so that this method can be reused in the inherited class Comment
	    #
	    class_name = self.name.split('::')[1]              # Post or Comment
	    elem_docs = doc.search "//#{class_name.downcase}"  # doc.search '//post' or doc.search '//commnet'

	    elems = elem_docs.map do |elem_doc|
		elem = self.new(elem_doc)                      # self.new will be Post.new or Comment.new

		# set person_id
		elem.person_id = elem_doc.at('id').inner_html if elem_doc.at('id')


		# set datetime
		# datetime will use 'updated' or 'pubdate'
		# if both exist, pubdate will be used
		timestr = elem_doc.at('updated').inner_html if elem_doc.at('updated')
		timestr = elem_doc.at('pubdate').inner_html if elem_doc.at('pubdate')
		elem.datetime = Time.gm( * timestr.split(/[-T:Z]/) ) if timestr


		# set tags
		tags_doc = elem_doc.at('tags')
		elem.tags = tags_doc.search("//tag").map do |tag_doc|
		    if API.config['encoding']=='euckr' 
			Tag.new(tag_doc.at('name').inner_html.ncr_euckr, tag_doc.at('url').inner_html.ncr_euckr)
		    else
			Tag.new(tag_doc.at('name').inner_html.ncr_utf8, tag_doc.at('url').inner_html.ncr_utf8)
		    end
		end if tags_doc

		elem
	    end
	end



	# reading of attributes like 'kind', 'body' are implemented through method_missing
	# because there is no need for special parsing algorithm.
	#
	def method_missing(name, *args)
	    if @doc and v = @doc.at(name) then 
		str = v.inner_text
		API.config['encoding']=='euckr' ? str.ncr_euckr : str.ncr_utf8
	    else
		raise NoMethodError, "#{name} is not defined as method nor as xml element" 
	    end
	end

    end
end
