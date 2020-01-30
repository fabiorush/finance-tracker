Rails.application.routes.draw do
  get 'stocks/search'
  devise_for :users
  root 'welcome#index'
  get 'portifolio', to: 'users#portifolio'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
