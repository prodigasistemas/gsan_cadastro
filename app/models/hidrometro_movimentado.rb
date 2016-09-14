class HidrometroMovimentado < ActiveRecord::Base
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_movimentado'
  self.primary_keys = 'himv_id', 'hidr_id'

  alias_attribute "hidrometro_movimentacao_id", "himv_id"
  alias_attribute "hidrometro_id", "hidr_id"
  alias_attribute "ultima_alteracao", "hdmv_tmultimaalteracao"

  belongs_to :hidrometro, foreign_key: "hidr_id"
  belongs_to :hidrometro_movimentacao, foreign_key: "himv_id"
end