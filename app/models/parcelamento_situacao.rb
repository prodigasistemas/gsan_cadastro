class ParcelamentoSituacao < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  TYPES = {
    :ATIVO          => 1,
    :DESFEITO       => 2,
    :CONCLUIDO      => 3,
    :CANCELADO      => 4
  }

  self.table_name = 'cobranca.parcelamento_situacao'
  self.primary_key = 'pcst_id'

  alias_attribute "id",                 "pcst_id"
  alias_attribute "descricao",          "pcst_dsparcelamentosituacao"
  alias_attribute "abreviado",          "pcst_dsabreviado"
  alias_attribute "ultima_alteracao",   "parc_vlconta"

  belongs_to :parcelamento, foreign_key: :id, class_name: 'Parcelamento'

end