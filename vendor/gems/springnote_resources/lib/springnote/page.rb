module Springnote
  class Page < Base
    def self.with_tags(tags)
      find(:all, :params => {:tags => tags})
    end
  
    def self.search(query)
      find(:all, :params => {:q => query})
    rescue RuntimeError
      # empty elements result causes error in typecast_xml_value because of xmlns of springnote
      []
    end
  
    def lock
      Lock.find(:relation_is_part_of => self.id)
    end
  
    def attachments
      Attachment.find(:all, :params => {:relation_is_part_of => self.id})
    end
  end
end # module Springnote
