class ImovelTipoConstrucao < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.imovel_tipo_construcao'
    self.primary_key = 'imco_id'
  
    alias_attribute "id", "imco_id"
    alias_attribute "descricao", "imco_dstipoconstrucao"
    alias_attribute "indicador_uso", "imco_icuso"
    alias_attribute "ultima_alteracao", "imco_tmultimaalteracao"
  end