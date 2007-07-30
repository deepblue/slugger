module Springnote
  class Base < ActiveResource::Base
    set_primary_key 'identifier'
    
    def id
      attributes["identifier"]
    end

    def id=(id)
      attributes["identifier"] = id
    end
    
    def to_param
      identifier.to_s
    end
    
    class <<self
      attr_accessor_with_default :configuration, Springnote::Configuration.new
    end    
  end # Base
end # module Springnote
