class DocumentoTipo < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model
  
  self.table_name  = 'cobranca.documento_tipo'
  self.primary_key = 'dotp_id'

  alias_attribute "id",                      "dotp_id"
  alias_attribute "descricao",               "dotp_dsdocumentotipo"
  alias_attribute "descricao_abreviado",     "dotp_dsabreviado"
  alias_attribute "indicador_pagavel",       "dotp_icpagavel"
  alias_attribute "indicador_agregador",     "dotp_icagregador"
end 