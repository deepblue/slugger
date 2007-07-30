require 'iconv'

class String
    def ncr_utf8
	copy = self.gsub(/&\#(\d+);/n) { [$1.to_i].pack("U*") }
	copy.gsub(/&\#x([0-9a-f]+);/ni) { [$1.hex].pack("U*") }
    end

    def utf8_euckr
	begin
	    Iconv.iconv('euckr', 'utf-8', self)[0]
	rescue
	    self
	end
    end

    def ncr_euckr
	self.ncr_utf8.utf8_euckr
    end
end
