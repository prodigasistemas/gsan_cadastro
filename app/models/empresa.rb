class Empresa < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name = 'cadastro.empresa'
  self.primary_key = 'empr_id'

  alias_attribute "id",                    "empr_id"
  alias_attribute "nome",                  "empr_nmempresa"
  alias_attribute "email",                 "empr_dsemail"
  alias_attribute "ativo",                 "empr_icuso"
  alias_attribute "ultima_alteracao",      "empr_tmultimaalteracao"
  alias_attribute "principal",             "empr_icempresaprincipal"
  alias_attribute "cobranca",              "empr_iccobranca"
  alias_attribute "leitura",               "empr_icleitura"
  alias_attribute "encerramento_contrato", "empr_dtenccontrcob"
  alias_attribute "meses_pagamento",       "empr_nnmesesvalidopagto"
  alias_attribute "validar_pagamento",     "empr_icvalidarpagamento"

  validates :ativo, :principal, :leitura, :cobranca,
            :validar_pagamento, inclusion: [1, 2]

  has_many :contrato_medicoes, foreign_key: "empr_id"

  has_many :leituristas, foreign_key: "empr_id"
  has_many :usuarios, through: :leituristas, foreign_key: "usur_id"
  has_many :imovel_retornos, through: :leituristas, foreign_key: :rota_id
end