class FaturamentoSituacaoTipo < ActiveRecord::Base
    self.table_name  = 'faturamento.fatur_situacao_tipo'
    self.primary_key = 'ftst_id'
  
    alias_attribute "id",               "ftst_id"
    alias_attribute "descricao",        "ftst_dsfaturamentosituacaotipo"
end