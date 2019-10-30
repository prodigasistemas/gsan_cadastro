class DevolucaoSituacao < ActiveRecord::Base
  self.table_name  = 'arrecadacao.devolucao_situacao'
  self.primary_key = 'dvst_id'

  alias_attribute "id",                  "dvst_id"
  alias_attribute "descricao",           "dvst_dsdevolucaosituacao"
  alias_attribute "descricao_abreviada", "dvst_dsabreviado"
  alias_attribute "ultima_alteracao",    "dvst_tmultimaalteracao"
  alias_attribute "indicador_uso",       "dvst_icuso"
  
end