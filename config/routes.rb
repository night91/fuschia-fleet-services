Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :auth do
    post 'cpplogin', to: 'authentication#login'
    post 'logout', to: 'authentication#logout'
    get 'callback', to: 'authentication#callback'
  end

  namespace :recruit do
    get 'mailing/add', to: 'recruiting_mailing#new'
    post 'mailing/add', to: 'recruiting_mailing#create'
    get 'mailing/all', to: 'recruiting_mailing#index'
  end

  resources :reimbursements do
    post :accept
    post :reject
  end
end
