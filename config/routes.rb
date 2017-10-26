PosRetail::Application.routes.draw do
  
  get "reports/index"
    get "reports/sale_report"
    post "reports/sale_report" , :as => 'download'

 # post "reports/sale_report/generate_report", :as =>'download'


  resources :sale_report do
  collection do
    get :download
    post 'sale_report'
  end
#  root to: "reports#sale_report"

  end

  resources :purchase_orders do
    resources :purchase_order_products do
       collection do
         get :add
         get :del
         get :new
          get :edit
         # patch :update
       end
       member do
         # get :edit
        # get :update_products
         get :remove_order_product
       end
    end

    member do
      get :complete_order
      get :download
    end
  end


  resources :reminders
  mount Plutus::Engine => "/pos", :as => "plutus"

  devise_for :users
  
  resources :products do
    collection do
      get :download
    end
  end
  resources :orders do
    collection do
      get 'purchase_order'
      get 'sale_order'
      get 'sale_report'
    end
  end
  resources :order_products, only: [:destroy] do
    collection do
      get 'create_order_product'
      post 'update_quantity'
    end
  end

  root to: "users#index"
end

# == Route Map
#
#                   Prefix Verb   URI Pattern                    Controller#Action
#         new_user_session GET    /users/sign_in(.:format)       devise/sessions#purchase_order
#             user_session POST   /users/sign_in(.:format)       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
#            user_password POST   /users/password(.:format)      devise/passwords#create
#        new_user_password GET    /users/password/purchase_order(.:format)  devise/passwords#purchase_order
#       edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
#                          PATCH  /users/password(.:format)      devise/passwords#update
#                          PUT    /users/password(.:format)      devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
#        user_registration POST   /users(.:format)               devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)       devise/registrations#purchase_order
#   edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
#                          PATCH  /users(.:format)               devise/registrations#update
#                          PUT    /users(.:format)               devise/registrations#update
#                          DELETE /users(.:format)               devise/registrations#destroy
#                     root GET    /                              users#index
#                   plutus        /plutus                        Plutus::Engine
#
# Routes for Plutus::Engine:
#                     root GET /                                   plutus/reports#balance_sheet
#    reports_balance_sheet GET /reports/balance_sheet(.:format)    plutus/reports#balance_sheet
# reports_income_statement GET /reports/income_statement(.:format) plutus/reports#income_statement
#                 accounts GET /accounts(.:format)                 plutus/accounts#index
#                  entries GET /entries(.:format)                  plutus/entries#index
#
