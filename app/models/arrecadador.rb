class Arrecadador < ActiveRecord::Base
  self.table_name  = 'arrecadacao.arrecadador'
  self.primary_key = 'arrc_id'

  alias_attribute "id",                      "arrc_id"
  alias_attribute "numeroInscricaoEstadual", "arrc_nninscricaoestadual"
  alias_attribute "codigoAgente",            "arrc_cdagente"
  alias_attribute "ultimaAlteracao",         "arrc_tmultimaalteracao"
  alias_attribute "indicadorUso",            "arrc_icuso"
  
  belongs_to :cliente, foreign_key: 'clie_id', class_name: 'Cliente'
end