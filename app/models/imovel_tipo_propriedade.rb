class ImovelTipoPropriedade < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.imovel_tipo_propriedade'
    self.primary_key = 'impr_id'
  
    alias_attribute "id", "impr_id"
    alias_attribute "descricao", "impr_dstipopropriedade"
    alias_attribute "indicador_uso", "impr_icuso"
    alias_attribute "ultima_alteracao", "impr_tmultimaalteracao"
  end