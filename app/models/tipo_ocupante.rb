class TipoOcupante < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'cadastro.imovel_tipo_ocupante'
  self.primary_key = 'itpo_id'

  alias_attribute "id",               "itpo_id"
  alias_attribute "descricao",        "itpo_descricao"
  alias_attribute "em_uso",           "itpo_icuso"
  alias_attribute "atualizado_em",    "itpo_tmultimaalteracao"
end