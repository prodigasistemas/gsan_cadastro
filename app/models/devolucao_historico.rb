class DevolucaoHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name = 'arrecadacao.devolucao_historico'
  self.primary_key = 'dehi_id'

  alias_attribute "id",                             "dehi_id"
  alias_attribute "ano_mes_referencia_arrecadacao", "dehi_amreferenciaarrecadacao"
  alias_attribute "data_devolucao",                 "dehi_dtdevolucao"
  alias_attribute "ultima_alteracao",               "dehi_tmultimaalteracao"   
  alias_attribute "ano_mes_referencia_devolucao",   "dehi_amreferenciadevolucao"
  alias_attribute "valor_devolucao",                "dehi_vldevolucao"

  belongs_to :imovel, foreign_key: 'imov_id'
  belongs_to :guia_devolucao, foreign_key: 'gdev_id'
  belongs_to :debito_tipo, foreign_key: 'dbtp_id'
  belongs_to :aviso_bancario, foreign_key: 'avbc_id'
  belongs_to :situacao_devolucao_atual, foreign_key: "dvst_idatual", class_name: 'DevolucaoSituacao'
  belongs_to :situacao_devolucao_anterior, foreign_key: "dvst_idanterior", class_name: 'DevolucaoSituacao'

  def self.por_imovel(imovel_id)
    joins("left join  arrecadacao.guia_devolucao g_dev on g_dev.gdev_id = arrecadacao.devolucao_historico.gdev_id")    
    .joins("left join  faturamento.conta con 			on con.cnta_id = g_dev.cnta_id ")
    .joins("left join  cadastro.cliente_conta cli_con	on cli_con.cnta_id = con.cnta_id")
    .joins("left join  cadastro.imovel imov				on imov.imov_id = arrecadacao.devolucao_historico.imov_id ")
    .joins("left join  cadastro.localidade loca			on loca.loca_id = imov.loca_id")
    .joins("left join  cadastro.setor_comercial set_com on set_com.stcm_id = imov.stcm_id")
    .joins("left join  cadastro.quadra quad 			on quad.qdra_id = imov.qdra_id")
    .joins("left join  faturamento.debito_tipo dep_tip	on dep_tip.dbtp_id = arrecadacao.devolucao_historico.dbtp_id") 
    .joins("left join  arrecadacao.aviso_bancario av_ba	on av_ba.avbc_id = arrecadacao.devolucao_historico.avbc_id ")
    .joins("left join  arrecadacao.arrecadador arre 	on arre.arrc_id = av_ba.arrc_id")
    .joins("left join  cadastro.cliente cli				on cli.clie_id = arre.clie_id ")
    .joins("left join  arrecadacao.devolucao_situacao devatu on devatu.dvst_id = arrecadacao.devolucao_historico.dvst_idatual") 
    .joins("left join  cobranca.documento_tipo doc_tip  on doc_tip.dotp_id = g_dev.dotp_id ")
    .joins("left join  cadastro.gerencia_regional geren on geren.greg_id = loca.greg_id ")
    .joins("left join  cadastro.cliente_imovel cli_imov	on cli_imov.imov_id = imov.imov_id")  
    .joins("left join faturamento.guia_pagamento guiap  on guiap.gpag_id = g_dev.gpag_id ")
    .joins("left join cadastro.cliente_guia_pagamento cli_guia on cli_guia.gpag_id = guiap.gpag_id")
    .distinct
    .where(imov_id: imovel_id)
  end
end
