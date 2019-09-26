class ClienteImovel < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.cliente_imovel'
  self.primary_key = 'clim_id'

  alias_attribute "id", "clim_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "data_inicio_relacao", "clim_dtrelacaoinicio"
  alias_attribute "data_fim_relacao", "clim_dtrelacaofim"
  alias_attribute "motivo_fim_relacao_id", "cifr_id"
  alias_attribute "ultima_alteracao", "clim_tmultimaalteracao"
  alias_attribute "tipo_relacao", "crtp_id"
  alias_attribute "nome_conta", "clim_icnomeconta"
  alias_attribute "cliente_relacao_tipo_id", "crtp_id"

  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :cliente, foreign_key: :clie_id
  belongs_to :cliente_relacao_tipo, foreign_key: :crtp_id

  scope :excecoes, -> (imovel_id) { includes(
    imovel: [:poco_tipo, 
      ligacao_esgoto: [:ligacao_esgoto_diametro, :ligacao_esgoto_material, :ligacao_esgoto_perfil, :ligacao_esgoto_esgotamento, :ligacao_esgoto_caixa_inspecao, :ligacao_esgoto_destino_dejetos, :ligacao_esgoto_destino_aguas_pluviais], 
      ligacao_agua:   [:ligacao_agua_diametro, :ligacao_agua_material, :ligacao_agua_perfil, 
        hidrometro_instalacao_historico: [:medicao_tipo, 
          hidrometro: [:hidrometro_capacidade, :hidrometro_tipo, :hidrometro_marca, :hidrometro_diametro, :hidrometro_relojoaria]]], 
      rota_alternativa: [:faturamento_grupo, :empresa]]).where(imov_id: imovel_id, motivo_fim_relacao_id: nil, tipo_relacao: 2).first }
end