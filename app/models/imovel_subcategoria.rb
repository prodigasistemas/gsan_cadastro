class ImovelSubcategoria < ActiveRecord::Base
  self.table_name  = 'cadastro.imovel_subcategoria'

  alias_attribute "subcategoria_id", "scat_id"
  alias_attribute "imovel_id",       "imov_id"
  alias_attribute "atualizado_em",   "imsb_tmultimaalteracao"
  alias_attribute "qtd_economias",   "imsb_qteconomia"

  belongs_to :imovel,       foreign_key: :imov_id
  belongs_to :subcategoria, foreign_key: :scat_id
end