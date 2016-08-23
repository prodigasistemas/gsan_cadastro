class TabelaColuna < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'seguranca.tabela_coluna'
  self.primary_key = 'tbco_id'

  alias_attribute :id,          :tbco_id
  alias_attribute :nome_coluna, :tbco_nmcoluna

  has_many :coluna_atualizacao_cadastrais, foreign_key: :tbco_id
end