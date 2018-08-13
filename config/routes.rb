Rails.application.routes.draw do
  devise_for :users
  root "flats#index"
  resources :flats do
    resources :bookings
  end
  resources :bookings
  resources :messages

  resources :users
  get '/secret', to: 'users#secret'
  get '/bookings_on_my_flat', to: 'bookings#vedor_booking'
  get '/get_secret_email', to: 'users#get_secret_email'
end
