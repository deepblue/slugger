module SettingsXml
    def simple_settings_xml
      xml = %{
    <?xml version="1.0" encoding="UTF-8"?>
    <settings settingsOf="codian">
      <mytags>tag1 tag2</mytags>
      <mytagsInTab>&#53076;&#46356;&#50504; &#44396;&#44544;</mytags>
      <description>description1</description>
    </settings> 
  }
    end
end
