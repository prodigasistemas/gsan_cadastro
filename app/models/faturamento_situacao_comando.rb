class FaturamentoSituacaoComando < ActiveRecord::Base
    self.table_name  = 'faturamento.fatur_situacao_comando'
    self.primary_key = 'ftsc_id'
  
    alias_attribute "id", "ftsc_id"
    
    belongs_to :usuario, foreign_key: :usur_id
end