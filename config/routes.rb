Rails.application.routes.draw do
  resources :measurements do
    resources :measures
  end
end