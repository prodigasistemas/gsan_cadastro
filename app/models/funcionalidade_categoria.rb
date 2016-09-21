class FuncionalidadeCategoria < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = "seguranca.funcionalidade_categoria"
  self.primary_key = "fncg_id"

  alias_attribute "id",             "fncg_id"
  alias_attribute "descricao",      "fncg_dsfuncionalidadecategoria"
  alias_attribute "superior",       "fncg_idsuperior"
  alias_attribute "em_uso",         "fncg_icuso"
  alias_attribute "modulo_id",      "modu_id"
  alias_attribute "atualizado_em",  "fncg_tmultimaalteracao"

  belongs_to :modulo, foreign_key: :modu_id
  belongs_to :topitem, class_name: "FuncionalidadeCategoria", foreign_key: "fncg_idsuperior"
  has_many :funcionalidades, foreign_key: :fncg_id

  has_many :subitens, class_name: "FuncionalidadeCategoria", foreign_key: "fncg_idsuperior"

  scope :para_as_funcionalidades, -> (funcionalidades_id) {
    joins(:funcionalidades)
    .where('funcionalidade.fncd_id in (?)', funcionalidades_id)
    .group('funcionalidade_categoria.fncg_id')
  }

  def categorias_superiores
    get_categorias_superiores(topitem, [])
  end

  private

  def get_categorias_superiores(item, itens)
    return itens if item.nil?
    itens << item
    get_categorias_superiores(item.topitem, itens)
    itens
  end
end