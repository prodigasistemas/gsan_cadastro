class Pagamento < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'arrecadacao.pagamento'
  self.primary_key = 'pgmt_id'

  alias_attribute 'id',                                   'pgmt_id'
  alias_attribute 'valor_pagamento',                      'pgmt_vlpagamento'
  alias_attribute 'ano_mes_referencia',                   'pgmt_amreferenciapagamento'
  alias_attribute 'data_pagamento',                       'pgmt_dtpagamento'
  alias_attribute 'ano_mes_referencia_arrecadacao',       'pgmt_amreferenciaarrecadacao'
  alias_attribute 'situacao_atual_pagamento_id',          'pgst_idatual'
  alias_attribute 'conta_id',                             'cnta_id'
  alias_attribute 'tipo_debito_id',                       'dbtp_id'
  alias_attribute 'guia_pagamento_id',                    'gpag_id'
  alias_attribute 'localidade_id',                        'loca_id'
  alias_attribute 'situacao_anterior_pagamento_id',       'pgst_idanterior'
  alias_attribute 'tipo_documento_id',                    'dotp_id'
  alias_attribute 'aviso_bancario_id',                    'avbc_id'
  alias_attribute 'imovel_id',                            'imov_id'
  alias_attribute 'item_movimento_arrecadador_id',        'amit_id'
  alias_attribute 'forma_arrecadacao_id',                 'arfm_id'
  alias_attribute 'ultima_alteracao',                     'pgmt_tmultimaalteracao'
  alias_attribute 'debito_a_cobrar_id',                   'dbac_id'
  alias_attribute 'cliente_id',                           'clie_id'
  alias_attribute 'valor_excedente',                      'pgmt_vlexcedente'
  alias_attribute 'indicador_expurgado',                  'pgmt_icexpurgado'
  alias_attribute 'fatura_id',                            'fatu_id'
  alias_attribute 'documento_agregador_id',               'cbdo_id'
  alias_attribute 'tipo_documento_agregador',             'dotp_idagregador'
  alias_attribute 'data_hora_processamento',              'pgmt_tmprocessamento'
  alias_attribute 'confirmacao_cartao_debito_id',         'pacd_id'
  alias_attribute 'indicador_recuperacao_credito',        'pgmt_icclassrecupcredito'

  belongs_to :imovel, foreign_key: :imovel_id
  belongs_to :cliente, foreign_key: :cliente_id
  belongs_to :conta, foreign_key: 'cnta_id', class_name: 'Conta'
  belongs_to :situacao_pagamento_atual, foreign_key: "pgst_idatual", class_name: 'PagamentoSituacao'
  belongs_to :situacao_pagamento_anterior, foreign_key: "pgst_idanterior", class_name: 'PagamentoSituacao'

  scope :condicoes, -> {
    joins(:situacao_pagamento_atual)
    .joins(:conta)
    .joins('left join cadastro.cliente_imovel c on c.clie_id = arrecadacao.pagamento.clie_id')
    .where("c.clim_dtrelacaofim IS NULL")
    .where("arrecadacao.pagamento_situacao.pgst_dsabreviado = ?", 'NCONF')
    .order(ano_mes_referencia: :desc)
  }
end

