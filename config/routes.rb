Rails.application.routes.draw do
  
 



  mount Ckeditor::Engine => '/ckeditor'
  resources :announcements
  resources :quizzes
  resources :lessons do
    collection {post :sort}
  end
  resources :units
  resources :tracks
  resources :badges
  resources :resources
  get 'admin/show'
  get 'projects/add', to: 'projects#add'

  resources :events do
      resources :registrations, only: [:create, :destroy, :add_students_by_classroom, :add_students_by_school] do
          
          resources :signatures, only: [:new, :create, :send] do
              collection do
                  post :callbacks
                  post :sendsigrequest
              end
          end
          
          
          member do
              post :sign
              get :accept
              get :decline
          end
      end
      
      member do
          get :manage
          post :publish
          post :unpublish
          post :add_students_by_classroom
          post :add_students_by_school
      end
  end
  
  
  
  devise_for :users,
#    path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' },
    controllers: { registrations: "users/registrations", sessions: "users/sessions", :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'static_pages#home'
  
#  devise_scope :user do
#      delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
#  end

  get 'projects/add', to: 'projects#add'
  get 'editor', to: 'static_pages#editor'

 

  post 'projects/import', to: 'projects#import'

  post '/signatures/callbacks', to: 'signatures#callbacks'
  get '/signatures/callbacks', to: 'signatures#callbacks'
  post 'signatures/authorize_adobe', to: 'signatures#authorize_adobe'
  
  post '/users/invite_teacher', to: 'users#invite_teacher'



  resources :projects
  resources :schools
  resources :teachers
  resources :users  do
      member do
          get :toggle_approved
      end
  end

  resources :classrooms do
      member do 
        get :export_attendance
      end

      resources :enrollments, only: [:create, :destroy, :verify] do
        collection do
          post "verify"
        end
      end
  end
  
  resources :attendance_data do
          member do
              get :toggle_present
          end
  end

  resources :attendance_lists do
      
      member do
          post :toggle_status
          get :record
      end
      
      resources :attendance_data do
          
          member do
              get :mark_as_present
              get :toggle_present
          end
      end

  end


  resources :students do
      collection { post :import }
  end
  
  
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :mark_as_read
      post :restore
    end
    collection do
      delete :empty_trash
    end
  end
  
  resources :notifications, only: [:index, :show] do
      member do
          post :trash
          post :untrash
          post :mark_as_read
          post :mark_as_unread
      end
  end

  resources :messages, only: [:new, :create]
  
  
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
