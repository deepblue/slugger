module Rme2day
    class API
	DOMAIN = 'me2day.net'

        @@config = nil
        @@username = nil
        @@password = nil

        class << self
	    # set credential information to access private data 
	    def setup(me2day_id, user_key, app_key, encoding = :utf8)
		set_credential(me2day_id, user_key, app_key, encoding )
	    end

	    def set_credential(me2day_id, user_key, app_key, encoding = :utf8 )
	       @@config = {
	           'me2day_id' => me2day_id,
		   'user_key' => user_key,
	           'app_key' => app_key,
		   'encoding' => encoding
	       }
         @@username = nil
         @@password = nil
	    end

            def config
		raise "Call Rspringnote::set_credentail to set your id and keys " unless @@config
                @@config 
            end

            def username
                @@username || @@username = set_username
            end

            def password
                @@password || @@password = set_password
            end

            def set_username
                @@username = CGI.escape(config['me2day_id'])
            end

            def set_password
                @@password = CGI.escape(digestkey)
            end

            def digestkey
                nonce = sprintf("%08x", rand(16 ** 8))
		nonce + Digest::MD5.hexdigest(nonce + config['user_key'].to_s)
            end


	    
	    #
	    # me2day read/write methods
	    #
	    def get_latests(person_id)
		do_open latests_post_url(person_id) 
	    end

	    def get_comments(permalink)
		do_open get_comments_url(permalink) 
	    end

	    def get_person(person_id)
		do_open get_person_url(person_id) 
	    end

	    def get_friends(person_id, scope = 'all')
		do_open get_friends_url(person_id, scope) 
	    end

	    def get_settings(person_id)
		do_open(get_settings_url , :auth_needed => true)
	    end

	    def create_post(body, tags, icon)
		url = create_post_url + create_post_params(body, tags, icon)
		do_open(url , :auth_needed => true)
	    end

	    def create_comment(permalink, body)
		url = create_comment_url + create_comment_params(permalink, body)
		do_open(url, :auth_needed => true)
	    end

	    # get/put real http message
            def do_open(url, options = {:auth_needed => false})

		auth_needed = options.delete :auth_needed
                options = options.merge({:http_basic_authentication => [username, password]}) if auth_needed
                options = options.merge({'me2_application_key'=> config['app_key']}) if auth_needed

                open(url, options)
            end

	    #
	    # url build methods
	    #
	    
	    def latests_post_url(person_id)
		"http://#{DOMAIN}/api/get_latests/#{person_id}.xml"
	    end

	    def get_comments_url(permalink)
		"http://#{DOMAIN}/api/get_comments.xml?post_id=#{URI.encode(permalink)}"
	    end

	    def get_person_url(person_id)
		"http://#{DOMAIN}/api/get_person/#{person_id}.xml"
	    end

	    def get_friends_url(person_id, scope)
		"http://#{DOMAIN}/api/get_friends/#{person_id}.xml?scope=#{scope}"
	    end

	    def get_settings_url
		"http://#{DOMAIN}/api/get_settings.xml"
	    end

	    def create_post_url
		"http://#{DOMAIN}/api/create_post/#{username}.xml"
	    end

	    def create_post_params(body, tags, icon)
		URI.encode("?post[body]=#{body}&post[tags]=#{tags}&post[icon]=#{icon}")
	    end

	    def create_comment_url
		"http://#{DOMAIN}/api/create_comment.xml"
	    end

	    def create_comment_params(permalink, body)
		URI.encode("?post_id=#{permalink}&body=#{body}")
	    end
	end
    end
end
