Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/restricted'
  get 'home/restricted'
  devise_for :users
  root to: "pages#home"

  devise_scope :user do
    get "/check_session_timeout" => "session_timeout#check_session_timeout"
    get "/session_timeout" => "session_timeout#render_timeout"
  end

  # get '/success', to "payment#success", as: "payment_success"
end
