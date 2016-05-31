Rails.application.routes.draw do

  root 'home#root'
  get 'Search' => 'adventure#search'
  get 'Guide' => 'home#guide'

  get 'Login' => 'account#login'
  post 'Login' => 'account#authenticate'
  get 'NewAccount' => 'account#new'
  post 'NewAccount' => 'account#create'

  get 'Adventure/:id' => 'adventure#get'
  get 'Stage' => 'stage#get'

  #route CUD on each model
  #requires controllers with edit, change, delete, destroy, new, create
  #UD take the :id parameter
  #edit, delete, new are GETs that should ask for info / confirmation
  #change, destroy, create are POSTs that should update the DB
  ["adventure","stage","pick","stagelayout","picklayout","image"].each do |model|
    ['edit','delete'].each do |action|
      get action.capitalize + '/' + model.capitalize + '/:id' => model + '#' + action
      post action.capitalize + '/' + model.capitalize + '/:id' => model + '#' + action
    end
    get 'New/' + model.capitalize => model + '#new'
    post 'New/' + model.capitalize => model + '#new'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
