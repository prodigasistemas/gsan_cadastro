class ImovelTipoOcupanteQuantidadeRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.imovel_tipo_ocupante_quantidade_retorno'
  self.primary_key = 'itqr_id'

  alias_attribute "id", "itqr_id"
  alias_attribute "quantidade", "itqr_quantidade"
  alias_attribute "imovel_tipo_ocupante_id", "itpo_id"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "imovel_retorno_id", "imre_id"
  alias_attribute "ultima_alteracao", "itqr_tmultimaalteracao"

  belongs_to :imovel_tipo_ocupante, foreign_key: "itpo_id"
  belongs_to :imovel, foreign_key: "imov_id"
  belongs_to :imovel_retorno, foreign_key: "imre_id"

  def descricao
    imovel_tipo_ocupante.descricao
  end
end