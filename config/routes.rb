Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # module 'api/' do
  #   post :register, to: "registrations#create"
  # end

  scope 'api' do
    post :register, to: "registrations#create"
    post :login, to: 'sessions#create'

    resources :tasks, only: [:create] do
      get :assigned, on: :collection
      post :assign
      patch :complete
    end
  end
end
