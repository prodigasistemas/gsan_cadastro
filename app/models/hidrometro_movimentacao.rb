class HidrometroMovimentacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_movimentado'
  self.primary_key = 'himv_id'

  alias_attribute "id", "himv_id"
  alias_attribute "data_movimentacao", "himv_dtmovimentacao"
  alias_attribute "hora_movimentacao", "himv_hrmovimentacao"
  alias_attribute "hidrometro_motivo_movimentacao_id", "himm_id"
  alias_attribute "descricao", "himv_dsparecer"
  alias_attribute "ultima_alteracao", "himv_tmultimaalteracao"
  alias_attribute "local_armazenagem_origem_id", "hila_idhidmtlocalarmzorigem"
  alias_attribute "local_armazenagem_destino_id", "hila_idhidmtlocalarmzdest"
  alias_attribute "usuario_id", "usur_id"

  belongs_to :usuario, foreign_key: "usur_id"
end