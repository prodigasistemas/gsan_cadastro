class LigacaoAguaMaterial < ActiveRecord::Base
    include IncrementableId
    include API::Model
  
    self.table_name = 'atendimentopublico.ligacao_agua_material'
    self.primary_key = 'lagm_id'
  
    alias_attribute "id",                 "lagm_id"
    alias_attribute "descricao",          "lagm_dsligacaoaguamaterial"
    alias_attribute "indicador_uso",      "lagm_icuso"
    alias_attribute "ultima_alteracao",   "lagm_tmultimaalteracao"
  
    
  end
  