Rails.application.routes.draw do



  root 'links#index'

  resources :links, expect: :index do
    resources :comments, only: %i[create edit update destroy]
  end

  get '/comments' => 'comments#index'

  resources :links, except: :index do
    resources :comments, only: %i[create edit update destroy]
    post :upvote, on: :member
    post :downvote, on: :member
  end

  get '/newest' => 'links#newest', as: :newest_links

  resources :sessions, only: %i[new create] do
    delete :destroy, on: :collection
  end

  resources :users, only: %i[new create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
