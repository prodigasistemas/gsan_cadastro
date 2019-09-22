class CobrancaAcao < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cobranca.cobranca_acao'
    self.primary_key = 'cbac_id'
  
    alias_attribute "id",                               "cbac_id"
    alias_attribute "descricao",                        "cbac_dscobrancaacao"
    alias_attribute "indicadorObrigatoriedade",         "cbac_icobrigatoriedade"
    alias_attribute "indicadorRepeticao",               "cbac_icrepeticao"
    alias_attribute "indicadorSuspensaoAbastecimento",  "cbac_icsuspensaoabastecimento"
    alias_attribute "numeroDiasValidade",               "cbac_nndiasvalidade"
    alias_attribute "numeroDiasMinimoAcaoPrecedente",   "cbac_nndiasminacaoprecedente"
    alias_attribute "indicadorCobrancaDebACobrar",      "cbac_iccobrancadebacobrar"
    alias_attribute "indicadorGeracaoTaxa",             "cbac_icgeracaotaxa"
end  
