class HidrometroMovimentado < ActiveRecord::Base
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_movimentado'
  self.primary_keys = 'himv_id', 'hidr_id'

  alias_attribute "hidrometro_movimentacao_id", "himv_id"
  alias_attribute "hidrometro_id", "hidr_id"
  alias_attribute "ultima_alteracao", "hdmv_tmultimaalteracao"

  alias_attribute "numero_hidrometro", "hidrometro_numero"
  alias_attribute "data_movimentacao", "hidrometro_data_movimentacao"
  alias_attribute "hora_movimentacao", "hidrometro_hora_movimentacao"

  belongs_to :hidrometro, foreign_key: "hidr_id"
  belongs_to :hidrometro_movimentacao, foreign_key: "himv_id"

  def hidrometro_numero
    hidrometro.try(:numero_hidrometro)
  end

  def hidrometro_data_movimentacao
    hidrometro_movimentacao.try(:data_movimentacao)
  end

  def hidrometro_hora_movimentacao
    hidrometro_movimentacao.try(:hora_movimentacao)
  end

  def movimentacao_local_origem
    hidrometro_movimentacao.try(:local_origem)
  end
end