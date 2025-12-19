Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'convert', to: 'conversions#convert'
      get 'conversions', to: 'conversions#index'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
