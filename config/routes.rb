Rails.application.routes.draw do
  resources :seasons
  resources :teachers
  resources :enrollments
  resources :activities
  resources :students
  devise_for :parents
  scope '/admin' do
    resources :parents
  end

  get '/enrollments/:id/success' => 'enrollments#success', as: :enrollment_success
  get '/enrollments/:id/pending' => 'enrollments#low_income', as: :enrollment_low_income
  get '/enrollments/:id/waiting_list' => 'enrollments#waiting_list', as: :enrollment_waiting_list
  post '/enrollments/:id/cancel' => 'enrollments#do_cancel', as: :enrollment_do_cancel
  get '/enrollments/:id/cancel' => 'enrollments#cancel', as: :enrollment_cancel

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # authenticated :parent do
  #   root :to => 'activities#index', as: :authenticated_root
  # end
  root :to => 'welcome#index'

  ##### Walkathon Paths #####

  # Disable student import; need to fix impl before enabling.
#  post 'students/import' => 'students#import', as: :import
  get 'student_search' => 'students#search', as: :student_search

  namespace :walkathon do
    resources :pledges, except: [:index] do
      resources :payments
    end
  end

  get 'walkathon' => 'walkathon/pledges#new', as: :walkathon
  get 'walkathon/payments' => 'walkathon/payments#index', as: :walkathon_payments
  get 'walkathon/thankyou' => 'walkathon/pledges#thankyou', as: :thankyou
  post 'walkathon/record_laps' => 'walkathon/pledges#record_laps', as: :record_laps
  get 'walkathon/record_laps' => 'walkathon/pledges#show_record_laps', as: :show_record_laps
  get 'walkathon/admin/pledge_summary' => 'walkathon/pledges#summary', as: :pledge_summary
  get 'walkathon/admin/pledges' => 'walkathon/pledges#index', as: :walkathon_admin_pledges
  get 'walkathon/pledges' => 'walkathon/pledges#for_current', as: :student_pledges

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
