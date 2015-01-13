Rails.application.routes.draw do
  resources :ceps
  resources :cep_tipos, only: :index
  resources :municipios, only: [:index, :show, :create, :update]
  resources :bairros, only: :index
  resources :tipo_logradouros, only: :index
  resources :unidade_federacoes, only: :index
  resources :micro_regioes, only: :index
  resources :regioes_desenvolvimento, only: :index
end
