Rails.application.routes.draw do

  require 'resque/server'
  HhParser::Application.routes.draw do
    mount Resque::Server.new, at: "/resque"
  end

  root 'vacancies#index'

  resources :vacancies, only: [:index, :show]
end
