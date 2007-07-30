# 메서드 결과를 한번만 실행하도록 cache 하는 코드
class Object
  class <<self
    def once(*methods)
      methods.each{|m| once_method(m)}
    end
    
    def once_method(method)
      origin = '_original_' + method.to_s
      alias_method origin, method
      define_method method do
        @_once_cache ||= {}
        @_once_cache[method] ||= send(origin)
      end
    end
  end
end