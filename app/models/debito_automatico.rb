class DebitoAutomatico < ActiveRecord::Base
    self.table_name  = 'arrecadacao.debito_automatico'
    self.primary_key = 'deba_id'
  
    alias_attribute "id",                                  "deba_id"
    alias_attribute "identificacaoClienteBanco",           "deba_dsidentificacaoclientebco"
    alias_attribute "dataOpcaoDebitoContaCorrente",        "deba_dtopcao"
    alias_attribute "dataInclusaoNovoDebitoAutomatico",    "deba_dtinclusao"
    alias_attribute "dataExclusao",                        "deba_dtexclusao"
    alias_attribute "agen_id",                             "agen_id"
    alias_attribute "imov_id",                             "imov_id"
    
    belongs_to :imovel, foreign_key:  :imov_id
    belongs_to :agencia, foreign_key: :agen_id    
end
