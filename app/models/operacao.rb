class Operacao < ActiveRecord::Base
  self.table_name  = 'seguranca.operacao'
  self.primary_key = 'oper_id'

  alias_attribute "id",                 "oper_id"
  alias_attribute "descricao",          "oper_dsoperacao"
  alias_attribute "abreviacao",         "oper_dsabreviado"
  alias_attribute "url",                "oper_dscaminhourl"
  alias_attribute "alterado_em" ,       "oper_tmultimaalteracao"
  alias_attribute "funcionalidade_id",  "fncd_id"

  belongs_to :funcionalidade, foreign_key: :fncd_id
end