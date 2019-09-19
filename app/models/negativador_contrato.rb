class NegativadorContrato < ActiveRecord::Base
    self.table_name  = 'cobranca.negativador_contrato'
    self.primary_key = 'ngcn_id'
  
    alias_attribute "id",                        "ngcn_id"
    alias_attribute "dataContratoInicio",        "ngcn_dtcontratoinicio"
    alias_attribute "dataContratoFim",           "ngcn_dtcontratofim"
    alias_attribute "dataContratoEncerramento",  "ngcn_dtcontratoencerramento"
    alias_attribute "numeroPrazoInclusao",       "ngcn_nnprazoinclusao"
    alias_attribute "negt_id",                   "negt_id"

    scope :ativos_por_negativador, -> (negativador) { where("negt_id = ? and (ngcn_dtcontratoencerramento is null or ngcn_dtcontratofim >= now())", negativador) }

    belongs_to :negativador,           foreign_key: :negt_id
end