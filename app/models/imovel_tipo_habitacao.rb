class ImovelTipoHabitacao < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.imovel_tipo_habitacao'
    self.primary_key = 'imha_id'
  
    alias_attribute "id", "imha_id"
    alias_attribute "descricao", "imha_dstipohabitacao"
    alias_attribute "indicador_uso", "imha_icuso"
    alias_attribute "ultima_alteracao", "imha_tmultimaalteracao"
  end