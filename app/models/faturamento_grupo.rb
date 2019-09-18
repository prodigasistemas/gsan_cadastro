class FaturamentoGrupo < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = "faturamento.faturamento_grupo"
  self.primary_key = "ftgr_id"

  alias_attribute "id",  "ftgr_id"
  alias_attribute "ano_mes_referencia", "ftgr_amreferencia"
  alias_attribute 'vencimento', 'ftgr_nndiavencimento'
end