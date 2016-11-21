# == Route Map
#
#                Prefix Verb                  URI Pattern                           Controller#Action
#                  root GET                   /                                     top#index
#                 about GET                   /about(.:format)                      top#about
#           bad_request GET                   /bad_request(.:format)                top#bad_request
# internal_server_error GET                   /internal_server_error(.:format)      top#internal_server_error
#        search_members GET                   /members/search(.:format)             members#search
#        member_entries GET                   /members/:member_id/entries(.:format) entries#index
#               members GET                   /members(.:format)                    members#index
#                       POST                  /members(.:format)                    members#create
#            new_member GET                   /members/new(.:format)                members#new
#           edit_member GET                   /members/:id/edit(.:format)           members#edit
#                member GET                   /members/:id(.:format)                members#show
#                       PATCH                 /members/:id(.:format)                members#update
#                       PUT                   /members/:id(.:format)                members#update
#                       DELETE                /members/:id(.:format)                members#destroy
#              articles GET                   /articles(.:format)                   articles#index
#                       POST                  /articles(.:format)                   articles#create
#           new_article GET                   /articles/new(.:format)               articles#new
#          edit_article GET                   /articles/:id/edit(.:format)          articles#edit
#               article GET                   /articles/:id(.:format)               articles#show
#                       PATCH                 /articles/:id(.:format)               articles#update
#                       PUT                   /articles/:id(.:format)               articles#update
#                       DELETE                /articles/:id(.:format)               articles#destroy
#            like_entry PATCH                 /entries/:id/like(.:format)           entries#like
#          unlike_entry PATCH                 /entries/:id/unlike(.:format)         entries#unlike
#         voted_entries GET                   /entries/voted(.:format)              entries#voted
#               entries GET                   /entries(.:format)                    entries#index
#                       POST                  /entries(.:format)                    entries#create
#             new_entry GET                   /entries/new(.:format)                entries#new
#            edit_entry GET                   /entries/:id/edit(.:format)           entries#edit
#                 entry GET                   /entries/:id(.:format)                entries#show
#                       PATCH                 /entries/:id(.:format)                entries#update
#                       PUT                   /entries/:id(.:format)                entries#update
#                       DELETE                /entries/:id(.:format)                entries#destroy
#               session POST                  /session(.:format)                    sessions#create
#                       DELETE                /session(.:format)                    sessions#destroy
#          edit_account GET                   /account/edit(.:format)               accounts#edit
#               account GET                   /account(.:format)                    accounts#show
#                       PATCH                 /account(.:format)                    accounts#update
#                       PUT                   /account(.:format)                    accounts#update
#            admin_root GET                   /admin(.:format)                      admin/top#index
#  search_admin_members GET                   /admin/members/search(.:format)       admin/members#search
#         admin_members GET                   /admin/members(.:format)              admin/members#index
#                       POST                  /admin/members(.:format)              admin/members#create
#      new_admin_member GET                   /admin/members/new(.:format)          admin/members#new
#     edit_admin_member GET                   /admin/members/:id/edit(.:format)     admin/members#edit
#          admin_member GET                   /admin/members/:id(.:format)          admin/members#show
#                       PATCH                 /admin/members/:id(.:format)          admin/members#update
#                       PUT                   /admin/members/:id(.:format)          admin/members#update
#                       DELETE                /admin/members/:id(.:format)          admin/members#destroy
#        admin_articles GET                   /admin/articles(.:format)             admin/articles#index
#                       POST                  /admin/articles(.:format)             admin/articles#create
#     new_admin_article GET                   /admin/articles/new(.:format)         admin/articles#new
#    edit_admin_article GET                   /admin/articles/:id/edit(.:format)    admin/articles#edit
#         admin_article GET                   /admin/articles/:id(.:format)         admin/articles#show
#                       PATCH                 /admin/articles/:id(.:format)         admin/articles#update
#                       PUT                   /admin/articles/:id(.:format)         admin/articles#update
#                       DELETE                /admin/articles/:id(.:format)         admin/articles#destroy
#                       GET|POST|PATCH|DELETE /*anything(.:format)                  top#not_found
#

Rails.application.routes.draw do
  root 'top#index'
  get 'about' => 'top#about', as: 'about'
  get 'bad_request' => 'top#bad_request'
  get 'internal_server_error' => 'top#internal_server_error'
  resources :members do
    collection { get 'search' }
    resources :entries, only: [:index]
  end
  resources :articles
  resources :entries do
    member { patch 'like', 'unlike' }
    collection { get 'voted' }
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]

  namespace :admin do
    root to: 'top#index'
    resources :members do
      collection { get 'search' }
    end
    resources :articles
  end

  match '*anything' => 'top#not_found', via: [:get, :post, :patch, :delete]
end
