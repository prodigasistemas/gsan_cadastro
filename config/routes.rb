Rails.application.routes.draw do
  resources :ceps
  resources :cep_tipos, only: :index
  resources :municipios, only: :index
  resources :bairros, only: :index
  resources :tipo_logradouros, only: :index
  resources :unidade_federacoes, only: :index
end
