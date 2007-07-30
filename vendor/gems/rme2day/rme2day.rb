# Me2day API Libraray (ver 0.1)
#
# http://me2day.net/
#
# Author: ikspres (mail@ikspres.com)
# Modified: 2007.06.30
# License: Same as Ruby License
# 

require 'rubygems'
require 'cgi'
require 'digest/md5'
#require 'sha1'
require 'hpricot'
require 'rest-open-uri'
require 'builder'


#
# Rme2day 
#

require 'rme2day/util'
require 'rme2day/api'
require 'rme2day/tag'
require 'rme2day/record'
require 'rme2day/post'
require 'rme2day/comment'
require 'rme2day/person'
require 'rme2day/settings'


#= Usage
#
#== Setup (not needed if used only for reading posts and comments)
#
#  Rme2day::API.setup('your id', 'user key', 'app key')
#      or
#  Rme2day::API.setup('your id', 'user key', 'app key', 'euckr') # if you want to print in EUC-KR
#
# (Notice! Rme2day::set_credential() is deprecated) 
#
#== Get lastest posts of a user, and comments for each post
#
#  posts = Rme2day::Post.find_latests('codian')
#  posts.each do |post|
#    puts post.body
#    puts post.kind
#    puts post.datetime
#    puts post.permalink
#    puts post.person_id
#
#       (or, to be simple)
#    puts post
#
#       (or, to be greedy)
#    post.print
#
#    post.comments.each do |comment|
#	puts comment.body
#	puts comment.datetime
#	puts comment.person_id
#
#          (or, to be simple)
#       puts comment   
#    end
#
#    author_id =  post.person_id
#    author = post.person      # see below for Person
#  end
#
#== Write a Post (set_credential needed before this)
#  post = Rme2day::Post.create ('hello world', 'greetings test', 1)
#
#
#== Get Person  and friends
#  codian = Rme2day::Person.get('codian')  #  get user directly with id, or
#  puts codian.id
#  puts codian.nickname 
#  ...                              # see me2day api document for more attributes 
#
#  codian.friends.each do |friend|  # each friend is also an object of Person 
#      puts firends.id
#      puts firends.nickname
#      ...
#  end
#
#
#== Get Settings (set_credential needed before this)
#
#  my_settings = Rme2day::Settings.get
# 


