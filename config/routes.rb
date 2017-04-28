Rails.application.routes.draw do

  root 'links#index'

  resources :links, except: :index

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :users, only: [:new, :create]
end
