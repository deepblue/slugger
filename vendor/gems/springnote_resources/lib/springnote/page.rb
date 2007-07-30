module Springnote
  class Page < Base        
    def lock
      Lock.find(:page_id => self.id)
    end    
  end
end
