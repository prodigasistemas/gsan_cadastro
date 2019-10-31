class AvisoBancario < ActiveRecord::Base
  self.table_name  = 'arrecadacao.aviso_bancario'
  self.primary_key = 'avbc_id'

  alias_attribute "id",                           "avbc_id"
  alias_attribute "data_lancamento",              "avbc_dtlancamento"
  alias_attribute "valor_contabilizado",          "avbc_vlcontabilizado"
  alias_attribute "ano_mes_referencia_arrecadacao","avbc_amreferenciaarrecadacao"
  alias_attribute "indicador_credito_debito",     "avbc_iccreditodebito"
  alias_attribute "numero_documento",             "avbc_nndocumento"
  
  belongs_to :arrecadador, foreign_key: 'arrc_id', class_name: 'Arrecadador'
end