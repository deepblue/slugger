module PostXml
    def generate_simple_posts_xml
      xml = %{
<?xml version="1.0" encoding="UTF-8"?>
<posts>
  <post>
    <permalink>http://me2day.net/codian/2007/06/30#13:03:34</permalink>
    <body>post body1</body>
    <kind>think</kind>
    <icon>http://me2day.net/images/post_think.gif</icon>
    <tags>
      <tag>
        <name>tag1</name>
        <url>http://me2day.net/codian/tag/tag1</url>
      </tag>
    </tags>
    <me2dayPage>http://me2day.net/codian</me2dayPage>
    <pubDate>2007-06-30T13:03:34Z</pubDate>
    <commentsCount>30</commentsCount>
    <metooCount>1</metooCount>
    <author>
      <id>codian</id>
      <nickname>nick1</nickname>
      <face>http://me2day.net/images/user/codian/profile.png</face>
      <homepage>http://codian.net</homepage>
      <me2dayHome>http://me2day.net/codian</me2dayHome>
    </author>
  </post>
  <post>
    <permalink>http://me2day.net/codian/2007/06/28#09:58:10</permalink>
    <body>post body2</body>
    <kind>think</kind>
    <icon>http://me2day.net/images/post_think.gif</icon>
    <tags>
      <tag>
        <name>tag1</name>
        <url>http://me2day.net/codian/tag/tag1</url>
      </tag>
      <tag>
        <name>tag2</name>
        <url>http://me2day.net/codian/tag/tag2</url>
      </tag>
    </tags>
    <me2dayPage>http://me2day.net/codian</me2dayPage>
    <pubDate>2007-06-28T09:58:10Z</pubDate>
    <commentsCount>18</commentsCount>
    <metooCount>15</metooCount>
    <author>
      <id>codian</id>
      <nickname>nick1</nickname>
      <face>http://me2day.net/images/user/codian/profile.png</face>
      <homepage>http://codian.net</homepage>
      <me2dayHome>http://me2day.net/codian</me2dayHome>
    </author>
  </post> 
</posts>
  }
    end

    def create_post_result_xml
      xml = %{
    <?xml version="1.0" encoding="UTF-8"?>
    <post>
      <permalink>http://me2day.net/me2daytest/2007/04/22#01:17:16</permalink>
      <body>&lt;a href="http://me2day.net"&gt;&#48120;&#53804;&#45936;&#51060;&lt;/a&gt;&#50640; &#44544;&#51012; &#50732;&#47549;&#45768;&#45796;.</body>
      <kind>think</kind>
      <icon>http://me2day.net/images/post_think.gif</icon>
      <tags>
        <tag>
          <name>me2api</name>
          <url>http://localhost:3000/me2daytest/tag/me2api</url>
        </tag>
        <tag>
          <name>create_post</name>
          <url>http://localhost:3000/me2daytest/tag/create_post</url>
        </tag>
        <tag>
          <name>&#44544;&#50416;&#44592;</name>
          <url>http://localhost:3000/me2daytest/tag/&#44544;&#50416;&#44592;</url>
        </tag>
      </tags>
      <me2dayPage>http://me2day.net/me2daytest</me2dayPage>
      <pubDate>2007-04-22T01:17:16Z</pubDate>
      <commentsCount>0</commentsCount>
      <metooCount>0</metooCount>
      <author>
        <id>me2daytest</id>
        <nickname>&#48120;&#53804;&#45936;&#51060;</nickname>
        <face>http://me2day.net/images/user/codian/&#54620;&#44544;&#51060;&#47492;.jpg</face>

        <homepage>http://me2day.net</homepage>
        <me2dayHome>http://me2day.net/me2daytest</me2dayHome>
      </author>
    </post>
      }
    end
end
