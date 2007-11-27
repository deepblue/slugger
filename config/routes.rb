ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  map.resources :pages, :has_many => :comments, :has_one => :trackback
  
  map.home    '/',      :controller => 'pages',  :action => 'index'
  map.connect 'xmlrpc', :controller => 'xmlrpc', :action => 'api',  :conditions => {:method => :post}
end