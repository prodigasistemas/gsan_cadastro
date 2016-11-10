class FaturamentoGrupo < ActiveRecord::Base
  self.table_name  = "faturamento.faturamento_grupo"
  self.primary_key = "ftgr_id"

  alias_attribute "id",              "ftgr_id"
end