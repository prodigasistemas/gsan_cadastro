class LigacaoAguaDiametro < ActiveRecord::Base
    include IncrementableId
    include API::Model
  
    self.table_name = 'atendimentopublico.ligacao_agua_diametro'
    self.primary_key = 'lagd_id'
  
    alias_attribute "id",                 "lagd_id"
    alias_attribute "descricao",          "lagd_dsligacaoaguadiametro"
    alias_attribute "indicador_uso",      "lagd_icuso"
    alias_attribute "ultima_alteracao",   "lagd_tmultimaalteracao"
  
    
  end
  