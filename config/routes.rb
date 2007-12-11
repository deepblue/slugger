ActionController::Routing::Routes.draw do |map|
  map.resources :pages, :has_many => [:comments, :trackbacks], :collection => {:search => :get}
  
  map.home    '/',      :controller => 'pages',  :action => 'index'
  map.connect 'xmlrpc', :controller => 'xmlrpc', :action => 'api',  :conditions => {:method => :post}
end
