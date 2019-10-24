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
  alias_attribute 'conta_id',                       'cnta_id'
  alias_attribute 'aviso_bancario_id',                    'avbc_id'
  alias_attribute 'situacao_atual_pagamento_id',          'pgst_idatual'
  alias_attribute 'situacao_anterior_pagamento_id',       'pgst_idanterior'
  alias_attribute 'cliente_id',                           'clie_id'
  alias_attribute 'tipo_debito_id',                       'dbtp_id'
  alias_attribute 'guia_pagamento_id',                    'gpag_id'
  alias_attribute 'imovel_id',                            'imov_id'
  
  belongs_to :imovel, foreign_key: :imovel_id
  belongs_to :conta, foreign_key: 'cnta_id', class_name: 'Conta'
  belongs_to :aviso_bancario, foreign_key: "avbc_id", class_name: "AvisoBancario"
  belongs_to :situacao_pagamento_atual, foreign_key: "pgst_idatual", class_name: 'PagamentoSituacao'
  belongs_to :situacao_pagamento_anterior, foreign_key: "pgst_idanterior", class_name: 'PagamentoSituacao'
  belongs_to :cliente, foreign_key: :cliente_id
  belongs_to :debito_tipo, foreign_key: 'dbtp_id', class_name: 'DebitoTipo'
  belongs_to :guia_pagamento, foreign_key: 'gpag_id', class_name: 'GuiaPagamento'

  def self.de_contas(imovel_id)
    joins("LEFT JOIN arrecadacao.aviso_bancario ab ON ab.avbc_id = arrecadacao.pagamento_historico.avbc_id")
    .joins("LEFT JOIN faturamento.guia_pagamento_geral gpg ON gpg.gpag_id = arrecadacao.pagamento_historico.gpag_id")
    .joins("LEFT JOIN faturamento.guia_pagamento_historico pgh ON pgh.gpag_id = gpg.gpag_id")
    .joins("LEFT JOIN arrecadacao.arrecadador arr ON arr.arrc_id = ab.arrc_id")
    .joins("LEFT JOIN cadastro.cliente cli ON cli.clie_id = arr.clie_id")
    .joins("LEFT JOIN cobranca.documento_tipo dt ON dt.dotp_id = arrecadacao.pagamento_historico.dotp_id")
    .joins("LEFT JOIN faturamento.conta_geral cg ON cg.cnta_id = arrecadacao.pagamento_historico.cnta_id")
    .joins("LEFT JOIN faturamento.conta_historico ch ON ch.cnta_id = cg.cnta_id")
    .joins("LEFT JOIN faturamento.debito_tipo dept ON dept.dbtp_id = pgh.dbtp_id")
    .joins("LEFT JOIN faturamento.debito_a_cobrar_geral dacg ON dacg.dbac_id = arrecadacao.pagamento_historico.dbac_id")
    .joins("LEFT JOIN faturamento.debito_a_cobrar dac ON dac.dbac_id = dac.dbac_id")
    .joins("LEFT JOIN faturamento.debito_tipo dtac ON dtac.dbtp_id = dac.dbtp_id")
    .joins("LEFT JOIN faturamento.debito_tipo dtph ON dtph.dbtp_id = arrecadacao.pagamento_historico.dbtp_id")
    .joins("LEFT JOIN arrecadacao.pagamento_situacao pgat ON pgat.pgst_id = arrecadacao.pagamento_historico.pgst_idatual")
    .joins("LEFT JOIN arrecadacao.pagamento_situacao pgan ON pgan.pgst_id = arrecadacao.pagamento_historico.pgst_idanterior")
    .distinct
    .where(imov_id: imovel_id)
    .order(localidade_id: :desc)
    .order(ano_mes_referencia: :desc)
    .order(imov_id: :desc)
    .order(data_pagamento: :desc)
  end
end

