OneTripWeb::Application.routes.draw do
  
  devise_for :users,
             :path => "",
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :skip => [:passwords, :registrations],
             :controllers => { :sessions => "admin/sessions" }

  root :to => 'home#index'
  
  namespace :admin do
    root :to => 'home#index'
    resources :provinces do
      post 'search', :on => :collection
      post 'destroy_multiple', :on => :collection
      get 'page/:page', :action => :index, :on => :collection
    end
    resources :places do
      post 'search', :on => :collection
      post 'destroy_multiple', :on => :collection
      get 'edit_map', :on => :member
      post 'update_map', :on => :member
      get 'page/:page', :action => :index, :on => :collection
      resources :infos
      resources :videos
      resources :audios
      resources :articles
    end
    resources :pictures
  end
  
end
