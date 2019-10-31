class ImovelCobrancaSituacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.imovel_cobranca_situacao'
  self.primary_key = 'iscb_id'

  alias_attribute "id",                         "iscb_id"
  alias_attribute "ultima_alteracao",           "iscb_tmultimaalteracao"
  alias_attribute "data_implantacao",           "iscb_dtimplantacaocobranca"
  alias_attribute "data_retirada",              "iscb_dtretiradacobranca"
  alias_attribute "data_exclusao",              "venc_dtexclusao"
  alias_attribute "ano_mes_referencia_inicio",  "iscb_amreferenciainicio"
  alias_attribute "ano_mes_referencia_final",   "iscb_amreferenciafinal"
  alias_attribute "imov_id",                    "imov_id"
  alias_attribute "cobranca_situacao_id",       "cbst_id"
  alias_attribute "cliente",                    "clie_id"
  alias_attribute "clie_idescritorio",          "clie_idescritorio"
  alias_attribute "clie_idadvogado",            "clie_idadvogado"
  alias_attribute "conta_motivo_revisao",       "cmrv_id"
  
  belongs_to  :escritorio,          foreign_key: :clie_idescritorio,  class_name: 'Cliente'
  belongs_to  :advogado,            foreign_key: :clie_idadvogado,  class_name: 'Cliente'
  belongs_to  :cliente,              foreign_key: :cliente,  class_name: 'Cliente'
  belongs_to  :cobranca_situacao, foreign_key: :cbst_id, class_name: 'CobrancaSituacao'

  delegate :escritorio, :to => :imovel, :allow_nil => true, :prefix => true
  delegate :advogado,   :to => :imovel, :allow_nil => true, :prefix => true
  delegate :cliente,    :to => :imovel, :allow_nil => true, :prefix => true
  delegate :descricao,  :to => :imovel, :allow_nil => true, :prefix => true

  scope :ordenar_por_data_implantacao, -> { order(data_implantacao: :desc) }
end