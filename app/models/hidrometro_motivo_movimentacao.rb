class HidrometroMotivoMovimentacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_motivo_movim'
  self.primary_key = 'himm_id'

  alias_attribute "id", "himm_id"
  alias_attribute "descricao", "himm_dshidmtmotivomovimentacao"
  alias_attribute "indicador_uso", "himm_icuso"
  alias_attribute "ultima_alteracao", "himm_tmultimaalteracao"
end