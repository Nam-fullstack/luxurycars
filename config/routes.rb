Rails.application.routes.draw do
  get 'home/restricted'
  devise_for :users
  root "pages#home"
end
