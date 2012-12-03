OneTripWeb::Application.routes.draw do
  
  get "admin/images"

  devise_for :users,
             :path => "",
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :skip => [:passwords, :registrations],
             :controllers => { :sessions => 'admin/sessions' }
  
  	
  match '/places/:url/map/:id' => 'images#show', :as => "map_place"
  match '/places/:url/videos/:id' => 'videos#show', :as => "video_place"
  match '/places/:url/audios/:id' => 'audios#show', :as => "audio_place"
  match '/places/:url/articles/:id' => 'articles#show', :as => "article_place"
  
  match '/minorities/:url' => 'minorities#show', :as => "minority"
  match '/minorities/:url/map/:id' => 'images#show', :as => "map_minority"
  match '/minorities/:url/videos/:id' => 'videos#show', :as => "video_minority"
  match '/minorities/:url/audios/:id' => 'audios#show', :as => "audio_minority"
  match '/minorities/:url/articles/:id' => 'articles#show', :as => "article_minority"
  
  namespace :admin do
    root :to => 'home#index'
    
    resources :settings, :only => [:index] do
      match 'index' => "settings#index", :on => :collection, :via => [:get, :post]
    end
    
    resources :users do
      post 'destroies', :on => :collection
      post 'search', :on => :collection
      match 'setting' => "users#setting", :on => :member, :via => [:get, :put]
      get 'permission', :on => :member
      get 'page/:page', :action => :search, :on => :collection
    end

    resources :roles do 
      post 'destroies', :on => :collection
      post 'search', :on => :collection
      get 'page/:page', :action => :search, :on => :collection
    end
    
    resources :provinces do
      post 'search', :on => :collection
      post 'destroies', :on => :collection
      get 'page/:page', :action => :search, :on => :collection
    end
    
    resources :places do
      post 'search', :on => :collection
      post 'destroies', :on => :collection
      get 'page/:page', :action => :show, :on => :member
      get 'page/:page', :action => :search, :on => :collection
      get 'publish/:status', :action => :publish, :on => :member, :as => :publish
      resources :areas, :except => [:index]
    end
    
    resources :minorities do
      post 'search', :on => :collection
      post 'destroies', :on => :collection
      get 'page/:page', :action => :search, :on => :collection
      get 'publish/:status', :action => :publish, :on => :member, :as => :publish
      resources :areas, :except => [:index]
    end
    
    resources :areas, :except => [:index] do
      resources :infos, :except => [:index, :show]
      resources :videos, :except => [:index, :show]
      resources :audios, :except => [:index, :show]
      resources :articles, :except => :index
      resources :images, :except => [:index, :show]
    end
    
    resources :area_categories, :except => :show do
      post 'search', :on => :collection
      post 'destroies', :on => :collection
      get 'page/:page', :action => :search, :on => :collection
    end
    
    resources :pictures
    
    resources :exceptions, :only => [:index]
    
    match ':category_slug' => 'categories#show', :as => :category, :via => [:get]
  end

  root :to => 'home#index'
  
end
