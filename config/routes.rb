Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check
  root 'pages#home'
  get "about", to: "pages#about"

  get 'whatsapp/start', to: 'whatsapp#start'
  get 'whatsapp/messageForm', to: 'whatsapp#messageForm'
  post 'whatsapp/send_message', to: 'whatsapp#send_message'

  resources :articles

end
