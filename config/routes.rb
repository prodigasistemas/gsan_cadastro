Rails.application.routes.draw do
  root to: 'home#index'

  resources :usuarios,                only: [:index, :show] do
    get "/empresa", action: :empresa
  end

  resources :ceps do
    get :search, :on => :collection
  end

  resources :bairros,                 only: [:index, :show, :create, :update]
  resources :clientes,                only: [:index, :show, :create, :update]
  resources :regioes,                 only: [:index, :show, :create, :update]
  resources :empresas,                only: [:index]
  resources :cep_tipos,               only: [:index, :show, :create, :update]
  resources :municipios,              only: [:index, :show, :create, :update]
  resources :profissoes,              only: [:index, :show, :create, :update]
  resources :logradouros,             only: [:index, :show, :create, :update]
  resources :autenticacao,            only: [:create]
  resources :esferas_poder,           only: [:index, :show, :create, :update]
  resources :cliente_tipos,           only: [:index, :show, :create, :update]
  resources :micro_regioes,           only: [:index, :show, :create, :update]
  resources :endereco_tipos,          only: [:index, :show, :create, :update]
  resources :ramos_atividade,         only: [:index, :show, :create, :update]
  resources :logradouro_tipos,        only: [:index, :show, :create, :update]
  resources :contrato_medicoes,       only: [:index, :show, :create, :update, :destroy] do
    resources :abrangencias,          only: [:create, :update, :destroy] do
      collection do
        delete :redefinir
      end
    end
  end
  resources :acoes,                   except: [:destroy]
  resources :abrangencias,            only: [:index]
  resources :coeficientes,            only: [:index, :show, :create, :update]
  resources :ligacao_agua_situacoes,  only: [:index]
  resources :logradouro_titulos,      only: [:index, :show, :create, :update]
  resources :unidade_federacoes,      only: [:index, :show, :create, :update]
  resources :enderecos_referencia,    only: [:index, :show, :create, :update]
  resources :orgaos_expedidores_rg,   only: [:index, :show, :create, :update]
  resources :regioes_desenvolvimento, only: [:index, :show, :create, :update]
  resources :fone_tipos,              only: :index
  resources :pessoa_sexos,            only: :index
  resources :bairro_areas,            only: :index
  resources :endereco_tipos,          only: :index
  resources :distrito_operacionais,   only: :index
  resources :localidades,             only: :index
  resources :imoveis,                 only: :index
  resources :menu,                    only: :show
  resources :setor_comercial,         only: :index
  resources :rotas,                   only: :index
  resources :quadras,                 only: :index
  resources :imovel_retornos,         only: :index

  resource :arquivo_hidrometro_instalacao_historicos, only: [:create, :show]
  get "/verifica_arquivo_hidrometro_historico", controller: :arquivo_hidrometro_instalacao_historicos, action: :verify

  resource :arquivo_recadastramento, only: [:create, :show]
  get "/verifica_arquivo_recadastramento", controller: :arquivo_recadastramentos, action: :verify
  get "/empresas_usuario/:usuario_id", controller: :empresas, action: :usuario

  resources :filtros, only: :index
  resources :associacoes, only: :index
end
