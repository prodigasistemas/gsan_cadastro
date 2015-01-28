Rails.application.routes.draw do
  resources :ceps do
    get :search, :on => :collection
  end

  resources :municipios,              only: [:index, :show, :create, :update]
  resources :bairros,                 only: [:index, :show, :create, :update]
  resources :logradouros,             only: [:index, :show, :create, :update]
  resources :clientes,                only: [:index, :show, :create, :update]
  resources :regioes,                 only: [:index, :show, :create, :update]
  resources :esferas_poder,           only: [:index, :show, :create, :update]
  resources :cliente_tipos,           only: [:index, :show, :create, :update]
  resources :micro_regioes,           only: [:index, :show, :create, :update]
  resources :regioes_desenvolvimento, only: [:index, :show, :create, :update]

  resources :cep_tipos,               only: [:index, :show, :create, :update]
  resources :profissoes,              only: :index
  resources :fone_tipos,              only: :index
  resources :pessoa_sexos,            only: :index
  resources :bairro_areas,            only: :index
  resources :endereco_tipos,          only: :index
  resources :tipo_logradouros,        only: :index
  resources :ramos_atividades,        only: :index
  resources :titulo_logradouros,      only: :index
  resources :unidade_federacoes,      only: :index
  resources :endereco_referencias,    only: :index
  resources :distrito_operacionais,   only: :index
  resources :orgaos_expedidores_rg,   only: :index
end
