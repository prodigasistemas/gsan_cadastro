class CobrancaAcao < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cobranca.cobranca_acao'
    self.primary_key = 'cbac_id'
  
    alias_attribute "id",                                   "cbac_id"
    alias_attribute "descricao",                            "cbac_dscobrancaacao"
    alias_attribute "indicador_obrigatoriedade",            "cbac_icobrigatoriedade"
    alias_attribute "indicador_repeticao",                  "cbac_icrepeticao"
    alias_attribute "indicador_suspensao_abastecimento",    "cbac_icsuspensaoabastecimento"
    alias_attribute "numero_dias_validade",                 "cbac_nndiasvalidade"
    alias_attribute "numero_dias_minimo_acao_precedente",   "cbac_nndiasminacaoprecedente"
    alias_attribute "indicador_cobranca_deb_a_cobrar",      "cbac_iccobrancadebacobrar"
    alias_attribute "indicador_geracao_taxa",               "cbac_icgeracaotaxa"
end  
