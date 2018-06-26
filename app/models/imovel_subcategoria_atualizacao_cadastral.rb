class ImovelSubcategoriaAtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'cadastro.imovel_subcatg_atlz_cad'
  self.primary_key = 'isac_id'

  alias_attribute :id,									:isac_id
  alias_attribute :categoria_id,				:catg_id
  alias_attribute :subcategoria_id,			:scat_id
  alias_attribute :economias,    				:isac_qteconomia

end