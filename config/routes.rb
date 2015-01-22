Rails.application.routes.draw do
  resources :ceps do
    get :search, :on => :collection
  end

  resources :municipios,    only: [:index, :show, :create, :update]
  resources :bairros,       only: [:index, :show, :create, :update]
  resources :logradouros,   only: [:index, :show, :create, :update]
  resources :clientes,      only: [:index, :show, :create, :update]

  resources :cep_tipos,               only: :index
  resources :profissoes,              only: :index
  resources :pessoa_sexos,            only: :index
  resources :cliente_tipos,           only: :index
  resources :esferas_poder,           only: :index
  resources :micro_regioes,           only: [:index, :create, :show, :edit, :update]
  resources :tipo_logradouros,        only: :index
  resources :ramos_atividades,        only: :index
  resources :titulo_logradouros,      only: :index
  resources :unidade_federacoes,      only: :index
  resources :bairro_areas,            only: :index
  resources :distrito_operacionais,   only: :index
  resources :regioes_desenvolvimento, only: :index
  resources :orgaos_expedidores_rg,   only: :index
  resources :regioes,   only: :index
end
