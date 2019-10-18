class PagamentoSituacao < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'arrecadacao.pagamento_situacao'
  self.primary_key = 'pgst_id'
  
  alias_attribute 'id',                   'pgst_id'
  alias_attribute 'descricao',            'pgst_dspagamentosituacao'
  alias_attribute 'descricao_abreviada',  'pgst_dsabreviado'
  alias_attribute 'indicador_uso',        'pgst_icuso'
  alias_attribute 'ultima_alteracao',     'pgst_tmultimaalteracao'

  belongs_to :pagamento, foreign_key: :id, class_name: 'Pagamento'
end