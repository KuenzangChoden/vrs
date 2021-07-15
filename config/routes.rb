Rails.application.routes.draw do
  devise_for :admins
  # resources :reports
  # get 'home/index'
  get 'home/guide'
  root 'home#index'

  resources :reports do
    member do 
      get :completed
    end

    member do 
      get :change_status
    end

     member do 
      get :rejected
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
