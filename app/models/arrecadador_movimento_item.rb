class ArrecadadorMovimentoItem < ActiveRecord::Base
  self.table_name  = 'arrecadacao.arrecadador_mov_item'
  self.primary_key = 'amit_id'

  alias_attribute "id",                   "amit_id"
  alias_attribute "conteudo_registro",    "amit_cnregistro"
  alias_attribute "ultima_alteracao",     "amit_tmultimaalteracao"
  alias_attribute "descricao_ocorrencia", "amit_dsocorrencia"
  alias_attribute "indicador_aceitacao",  "amit_icaceitacao"
  alias_attribute "valor_documento",      "amit_vldocumento"
  
end
		