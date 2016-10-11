Rails.application.routes.draw do
  root 'vacancies#index'

  resources :vacancies, only: [:index, :create, :show, :destroy]
end
