class Abrangencia < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'desempenho.contrato_medicao_abrangencia'
  self.primary_key = 'cmab_id'

  alias_attribute "id",                        "cmab_id"
  alias_attribute "criado_em",                 "cmab_tmcriacao"
  alias_attribute "atualizado_em",             "cmab_tmultimaalteracao"
  alias_attribute "contrato_medicao_id",       "cmed_id"
  alias_attribute "imovel_id",                 "imov_id"
  alias_attribute "ligacao_agua_situacao_id",  "last_id"

  belongs_to :contrato_medicao,      foreign_key: 'cmed_id'
  belongs_to :imovel,                foreign_key: 'imov_id'
  belongs_to :ligacao_agua_situacao, foreign_key: 'last_id'
end