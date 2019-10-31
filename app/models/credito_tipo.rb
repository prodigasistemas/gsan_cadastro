class CreditoTipo < ActiveRecord::Base
  self.table_name  = 'faturamento.credito_tipo'
  self.primary_key = 'crti_id'

  alias_attribute "id",                             "crti_id"
  alias_attribute "descricao",                      "crti_dscreditotipo"
  alias_attribute "descricao_abreviada",            "crti_dsabreviado"
  alias_attribute "indicador_uso",                  "crti_icuso"
  alias_attribute "ultima_alteracao",               "crti_tmultimaalteracao"
  alias_attribute "valor_limite",                   "crti_vllimite"
  alias_attribute "indicador_geracao_automatica",   "crti_icgeracaoautomatica"
  
end