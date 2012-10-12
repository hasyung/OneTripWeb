OneTripWeb::Application.routes.draw do
  
  devise_for :users,
             :path => "",
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :skip => [:passwords, :registrations],
             :controllers => { :sessions => "admin/sessions" }
  
  match "/places/:name" => "places#index", :as => :name_place
  
  namespace :admin do
    root :to => 'home#index'
    
    resources :settings, :only => [:installing] do
      match 'installing' => "settings#installing", :on => :collection, :via => [:get, :post]
    end
    
    resources :users do
      post 'destroies', :on => :collection
      post 'search', :on => :collection
      match 'setting' => "users#setting", :on => :member, :via => [:get, :put]
      get 'permission', :on => :member
      get 'page/:page', :action => :index, :on => :collection
    end

    resources :roles do 
      post 'destroies', :on => :collection
      post 'search', :on => :collection
      get 'page/:page', :action => :index, :on => :collection
    end
    
    resources :provinces do
      post 'search', :on => :collection
      post 'destroies', :on => :collection
      get 'page/:page', :action => :index, :on => :collection
    end
    
    resources :places do
      post 'search', :on => :collection
      get 'page/:page', :action => :index, :on => :collection
      get 'publish/:status', :action => :publish, :on => :member, :as => :publish
      resources :infos, :except => [:index, :show]
      resources :videos, :except => [:index, :show]
      resources :audios, :except => [:index, :show]
      resources :articles, :except => :index
    end
    
    resources :pictures
    
    resources :exceptions, :only => [:index]
  end
  
end
