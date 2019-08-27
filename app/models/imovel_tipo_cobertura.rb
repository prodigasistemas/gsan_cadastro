class ImovelTipoCobertura < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.imovel_tipo_cobertura'
    self.primary_key = 'imcb_id'
  
    alias_attribute "id", "imcb_id"
    alias_attribute "descricao", "imcb_dstipocobertura"
    alias_attribute "indicador_uso", "imcb_icuso"
    alias_attribute "ultima_alteracao", "imcb_tmultimaalteracao"
  end