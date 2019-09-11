class FaturamentoSituacaoHistorico < ActiveRecord::Base
    self.table_name  = 'faturamento.fatur_situacao_hist'
    self.primary_key = 'ftsh_id'
  
    alias_attribute "id",                               "ftsh_id"
    alias_attribute "anoMesFaturamentoSituacaoInicio",  "ftsh_amfatmtsitinicio"
    alias_attribute "anoMesFaturamentoSituacaoFim",     "ftsh_amfaturamentosituacaofim"
    alias_attribute "anoMesFaturamentoRetirada",        "ftsh_amfaturamentoretirada"
    alias_attribute "dataInclusao",                     "ftsh_tminclusao"
    alias_attribute "ftsm_id",                          "ftsm_id"
    alias_attribute "ftst_id",                          "ftst_id"    
    alias_attribute "imov_id",                          "imov_id"
    alias_attribute "usur_id",                          "usur_id"
    alias_attribute "ftsc_idinforma",                   "ftsc_idinforma"
    alias_attribute "ftsc_idretirada",                  "ftsc_idretirada"    
    
    belongs_to :imovel,                                foreign_key: :imov_id, class_name: 'Imovel'
    belongs_to :usuario,                               foreign_key: :usur_id, class_name: 'Usuario'
    belongs_to :faturamento_situacao_motivo,           foreign_key: :ftsm_id, class_name: 'FaturamentoSituacaoMotivo'
    belongs_to :faturamento_situacao_tipo,             foreign_key: :ftst_id, class_name: 'FaturamentoSituacaoTipo'
    belongs_to :faturamento_situacao_comando_informa,  foreign_key: :ftsc_idinforma,  class_name: 'FaturamentoSituacaoComando'
    belongs_to :faturamento_situacao_comando_retirada, foreign_key: :ftsc_idretirada, class_name: 'FaturamentoSituacaoComando'
end