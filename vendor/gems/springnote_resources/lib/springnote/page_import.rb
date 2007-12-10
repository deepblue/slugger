module Springnote::PageImport
  BOUNDARY = 'AaB03x'
  
  module ClassMethod
    def import_file(path)
      new.import_file(path)
    end  
  end

  def import_file(path)
    body = File.open(path) do |f|
      create_query_multipart_str({:Filedata => f}, BOUNDARY)
    end  
    headers = self.class.headers.merge 'Content-Transfer-Encoding' => 'binary',
      'Content-Length' => body.length.to_s,
      'Content-Type' => "multipart/form-data; boundary=#{BOUNDARY}"

    returning connection.post(collection_path, body, headers) do |response|
      self.id = id_from_response(response)
      load_attributes_from_response(response)
    end
    self      
  end
  
  def self.included(base)
    base.extend(ClassMethod)
  end
  

protected
  # COPY from ruby/facets 1.8.54
  def create_query_multipart_str(query, boundary)
    query.collect { |attr, value|
      value ||= ''
      if value.is_a? File
        params = {
          'filename' => value.path,
          # Creation time is not available from File::Stat
          # 'creation-date' => value.ctime.rfc822,
          'modification-date' => value.mtime.rfc822,
          'read-date' => value.atime.rfc822,
        }
        param_str = params.to_a.collect { |k, v|
          "#{k}=\"#{v}\""
        }.join("; ")
        "--#{boundary}\r\n" +
          %{Content-Disposition: form-data; name="#{attr.to_s}"; #{param_str}\r\n} +
          "Content-Transfer-Encoding: binary\r\n" + 
          "Content-Type: application/octet-stream\r\n\r\n#{value.read}\r\n"
      else
        "--#{boundary}\r\n" +
          %{Content-Disposition: form-data; name="#{attr.to_s}"\r\n} +
          "\r\n#{value.to_s}\r\n"
      end
    }.join('') + "--#{boundary}--\r\n"
  end  
end

Springnote::Page.send :include, Springnote::PageImport