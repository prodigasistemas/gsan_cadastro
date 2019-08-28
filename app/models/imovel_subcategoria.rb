class ImovelSubcategoria < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.imovel_subcategoria'

  alias_attribute "subcategoria_id", "scat_id"
  alias_attribute "imovel_id",       "imov_id"
  alias_attribute "atualizado_em",   "imsb_tmultimaalteracao"
  alias_attribute "qtd_economias",   "imsb_qteconomia"

  belongs_to :imovel,       foreign_key: :imov_id
  belongs_to :subcategoria, foreign_key: :scat_id

  def atributos(metodos = [])
    super([:categoria].concat(metodos))
  end

  private

  def dados_cadastrais
    teste = {}

    teste[:nome] = "JACK"

    teste
  end  
end
