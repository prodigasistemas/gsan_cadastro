class FaturamentoSituacaoMotivo < ActiveRecord::Base
    self.table_name  = 'faturamento.fatur_situacao_motivo'
    self.primary_key = 'ftsm_id'
  
    alias_attribute "id",               "ftsm_id"
    alias_attribute "descricao",        "ftsm_dsfatsitmotivo"
    alias_attribute "indicadorUso",     "ftsm_icuso"
end