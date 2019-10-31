class NegativadorRetornoMotivo < ActiveRecord::Base
  self.table_name  = 'cobranca.negatd_retorno_motivo'
  self.primary_key = 'nrmt_id'

  alias_attribute "id",                        "nrmt_id"
  alias_attribute "descricao",                 "nrmt_dsretornocod"
  alias_attribute "indicador_uso",             "nrmt_icuso"
  alias_attribute "indicador_registro_aceito", "nrmt_icregistroaceito"
  alias_attribute "codigo_retorno_motivo",     "nrmt_cdretornomotivo"

end