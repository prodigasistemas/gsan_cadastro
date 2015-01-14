class RegiaoDesenvolvimento < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.regiao_desenvolvimento'
  self.primary_key = 'rdes_id'

  alias_attribute "id",             "rdes_id"
  alias_attribute "nome",           "rdes_nmregiaodesenvolvimento"
  alias_attribute "ativo",          "rdes_icuso"
  alias_attribute "atualizado_em",  "rdes_tmultimaalteracao"

  default_scope -> { order(:nome) }
end
