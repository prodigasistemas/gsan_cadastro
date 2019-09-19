class LigacaoAguaPerfil < ActiveRecord::Base
    include IncrementableId
    include API::Model
  
    self.table_name = 'atendimentopublico.ligacao_agua_perfil'
    self.primary_key = 'lapf_id'
  
    alias_attribute "id",                 "lapf_id"
    alias_attribute "descricao",          "lapf_dsligacaoaguaperfil"
    alias_attribute "indicador_uso",      "lapf_icuso"
    alias_attribute "ultima_alteracao",   "lapf_tmultimaalteracao"
  
    
  end