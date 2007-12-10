require 'rubygems'
require 'hoe'
require File.dirname(__FILE__) + '/lib/springnote_resources'

Hoe.new("springnote_resources", Springnote::VERSION) do |p|
  p.rubyforge_name = "springnote"
  p.summary = "ActiveResource wrapper library for Springnote.com's REST API"
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 1).first.gsub(/^\* Homepage: /, '').split(/\n/)
  p.author = 'Bryan Kang'
  p.email = 'byblue@gmail.com'
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.need_zip = true
end

task :update_manifest do
  dirs = Dir['*txt'] + ['Rakefile', 'vendor']
  %w(lib spec).each {|dir| dirs += Dir["#{dir}/**/*"] }
  File.open('Manifest.txt', 'w') {|f| f.write(dirs.join("\n")) }  
end
