Rails.application.routes.draw do
  resources :measurements do
    resources :measures
  end
    post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end