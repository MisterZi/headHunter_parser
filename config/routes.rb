Rails.application.routes.draw do
  resources :vacancies, only: [:index, :create, :show, :destroy]
end
