Rails.application.routes.draw do
  resources :ceps do
    get :search, :on => :collection
  end
  resources :cep_tipos, only: :index
  resources :municipios, only: [:index, :show, :create, :update]
  resources :bairros, only: [:index, :show, :create, :update]
  resources :tipo_logradouros, only: :index
  resources :titulo_logradouros, only: :index
  resources :unidade_federacoes, only: :index
  resources :micro_regioes, only: :index
  resources :regioes_desenvolvimento, only: :index
  resources :logradouros, only: [:index, :show, :create, :update]
end
