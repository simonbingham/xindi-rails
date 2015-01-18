XindiRails::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy' # https://github.com/volmer/bootsy

  # application root

  root 'public/pages#index'

  # admin routes

  get 'admin' => 'admin/dashboard#index', as: 'admin_dashboard'

  get 'admin/articles' => 'admin/articles#index', as: 'admin_articles'
  get 'admin/articles/new' => 'admin/articles#new', as: 'admin_articles_new'
  get 'admin/articles/:id/edit' => 'admin/articles#edit', as: 'admin_articles_edit'
  post 'admin/articles' => 'admin/articles#create', as: 'admin_articles_create'
  patch 'admin/articles/:id' => 'admin/articles#update', as: 'admin_articles_update'
  delete 'admin/articles/:id' => 'admin/articles#destroy', as: 'admin_articles_destroy'

  get 'admin/enquiries' => 'admin/enquiries#index', as: 'admin_enquiries'
  get 'admin/enquiries/:id' => 'admin/enquiries#show', as: 'admin_enquiries_show'
  delete 'admin/enquiries/:id' => 'admin/enquiries#destroy', as: 'admin_enquiries_destroy'

  get 'admin/login' => 'admin/sessions#new', as: 'admin_login'
  post 'admin/login' => 'admin/sessions#create', as: 'admin_login_create'
  delete 'admin/logout' => 'admin/sessions#destroy', as: 'admin_logout'

  get 'admin/pages' => 'admin/pages#index', as: 'admin_pages'
  get 'admin/pages/new/:ancestor_id' => 'admin/pages#new', as: 'admin_pages_new'
  get 'admin/pages/:id/edit' => 'admin/pages#edit', as: 'admin_pages_edit'
  get 'admin/pages/move' => 'admin/pages#move', as: 'admin_pages_move'
  post 'admin/pages' => 'admin/pages#create', as: 'admin_pages_create'
  patch 'admin/pages/:id' => 'admin/pages#update', as: 'admin_pages_update'
  delete 'admin/pages/:id' => 'admin/pages#destroy', as: 'admin_pages_destroy'

  get 'admin/users' => 'admin/users#index', as: 'admin_users'
  get 'admin/users/new' => 'admin/users#new', as: 'admin_users_new'
  get 'admin/users/:id/edit' => 'admin/users#edit', as: 'admin_users_edit'
  post 'admin/users' => 'admin/users#create', as: 'admin_users_create'
  patch 'admin/users/:id' => 'admin/users#update', as: 'admin_users_update'
  delete 'admin/users/:id' => 'admin/users#destroy', as: 'admin_users_destroy'

  # public routes

  get 'contact' => 'public/enquiries#index', as: 'public_enquiries'
  post 'contact' => 'public/enquiries#create', as: 'public_enquiries_create'

  get 'search' => 'public/search#index', as: 'public_search'

  get 'news' => 'public/articles#index', as: 'public_articles'
  get 'news/:slug' => 'public/articles#show', as: 'public_articles_show'

  get ':slug' => 'public/pages#index'
  get ':slug/:child_slug' => 'public/pages#index'

end
