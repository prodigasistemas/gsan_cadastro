class PagamentoHistorico < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'arrecadacao.pagamento_historico'
  self.primary_key = 'pghi_id'

  alias_attribute 'id',                             'pghi_id'
  alias_attribute 'valor_pagamento',                'pghi_vlpagamento'
  alias_attribute 'valor_excedente',                'pghi_vlexcedente'
  alias_attribute 'ano_mes_referencia',   'pghi_amreferenciapagamento'
  alias_attribute 'data_pagamento',                 'pghi_dtpagamento'
  alias_attribute 'ano_mes_referencia_arrecadacao', 'pghi_amreferenciaarrecadacao'
  alias_attribute 'ultima_alteracao',               'pghi_tmultimaalteracao'
  alias_attribute 'codigo_agente',                  'pghi_cdagente'
  alias_attribute 'indicador_expurgado',            'pghi_icexpurgado'
  alias_attribute 'data_hora_processamento',        'pghi_tmprocessamento'
  alias_attribute 'localidade_id',                  'loca_id'
  alias_attribute 'tipo_documento_id',              'dotp_id'
  alias_attribute 'conta_geral_id',                       'cnta_id'
  alias_attribute 'aviso_bancario_id',                    'avbc_id'
  alias_attribute 'situacao_atual_pagamento_id',          'pgst_idatual'
  alias_attribute 'situacao_anterior_pagamento_id',       'pgst_idanterior'
  alias_attribute 'cliente_id',                           'clie_id'
  alias_attribute 'tipo_debito_id',                       'dbtp_id'
  alias_attribute 'guia_pagamento_geral_id',              'gpag_id'
  alias_attribute 'imovel_id',                            'imov_id'
  
  belongs_to :imovel, foreign_key: :imovel_id
  belongs_to :conta_geral, foreign_key: 'cnta_id', class_name: 'ContaGeral'
  belongs_to :aviso_bancario, foreign_key: "avbc_id", class_name: "AvisoBancario"
  belongs_to :situacao_pagamento_atual, foreign_key: "pgst_idatual", class_name: 'PagamentoSituacao'
  belongs_to :situacao_pagamento_anterior, foreign_key: "pgst_idanterior", class_name: 'PagamentoSituacao'
  belongs_to :cliente, foreign_key: :cliente_id
  belongs_to :debito_tipo, foreign_key: 'dbtp_id', class_name: 'DebitoTipo'
  belongs_to :guia_pagamento_geral, foreign_key: 'gpag_id', class_name: 'GuiaPagamentoGeral'
  belongs_to :documento_tipo, foreign_key: 'dotp_id', class_name: 'DocumentoTipo'
  belongs_to :debito_a_cobrar_geral, foreign_key: 'dbac_id', class_name: 'DocumentoTipo'

  def self.de_contas(imovel_id)
    distinct
    .joins("LEFT JOIN arrecadacao.aviso_bancario ab ON ab.avbc_id = arrecadacao.pagamento_historico.avbc_id")
		.joins("LEFT JOIN  faturamento.guia_pagamento_geral gpagGeral on gpagGeral.gpag_id = arrecadacao.pagamento_historico.gpag_id")
		.joins("LEFT JOIN  faturamento.guia_pagamento_historico gph on gph.gpag_id = gpagGeral.gpag_id")
		.joins("LEFT JOIN  arrecadacao.arrecadador arrec on arrec.arrc_id = ab.arrc_id")
		.joins("LEFT JOIN  cadastro.cliente cli on cli.clie_id = arrec.clie_id")
		.joins("LEFT JOIN  cobranca.documento_tipo doctoTp on doctoTp.dotp_id = arrecadacao.pagamento_historico.dotp_id")
		.joins("LEFT JOIN  faturamento.conta_geral cg on cg.cnta_id = arrecadacao.pagamento_historico.cnta_id")
		.joins("LEFT JOIN  faturamento.conta_historico ch on ch.cnta_id = cg.cnta_id")
		.joins("LEFT JOIN  faturamento.debito_tipo gdt on gdt.dbtp_id = gph.dbtp_id")    
		.joins("LEFT JOIN  faturamento.debito_a_cobrar_geral dacg on dacg.dbac_id = arrecadacao.pagamento_historico.dbac_id")
		.joins("LEFT JOIN  faturamento.debito_a_cobrar dac on dac.dbac_id = dacg.dbac_id")
		.joins("LEFT JOIN  faturamento.debito_tipo dtd on dtd.dbtp_id = dac.dbtp_id")
		.joins("LEFT JOIN  faturamento.debito_tipo dbtp on dbtp.dbtp_id =  arrecadacao.pagamento_historico.dbtp_id")
		.joins("LEFT JOIN  arrecadacao.pagamento_situacao pgstat on pgstat.pgst_id = arrecadacao.pagamento_historico.pgst_idatual")
		.joins("LEFT JOIN  arrecadacao.pagamento_situacao pgstan on pgstan.pgst_id = arrecadacao.pagamento_historico.pgst_idanterior")
    .where(imov_id: imovel_id)
    .order(localidade_id: :desc)
    .order(ano_mes_referencia: :desc)
    .order(imov_id: :desc)
    .order(data_pagamento: :desc)
  end
end

