class ImovelSubcategoriaAbrangencia < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'desempenho.imovel_subcategoria_abrangencia'
  self.primary_key = 'imsa_id'

  alias_attribute "id",              "imsa_id"
  alias_attribute "criado_em",       "imsa_tmcriacao"
  alias_attribute "atualizado_em",   "imsa_tmultimaalteracao"
  alias_attribute "subcategoria_id", "scat_id"
  alias_attribute "qtd_economias",   "imsa_qteconomias"
  alias_attribute "imovel_id",       "imov_id"

  belongs_to :imovel,           foreign_key: 'imov_id'
  belongs_to :subcategoria,     foreign_key: 'scat_id'
end