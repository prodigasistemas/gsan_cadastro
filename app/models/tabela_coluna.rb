class TabelaColuna < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'seguranca.tabela_coluna'
  self.primary_key = 'tbco_id'

  alias_attribute :id,                      :tbco_id
  alias_attribute :nome_coluna,             :tbco_nmcoluna
  alias_attribute :descricao_coluna,        :tbco_dscoluna
  alias_attribute :tabela_id,               :tabe_id

  has_many :coluna_atualizacao_cadastrais, foreign_key: :tbco_id
  belongs_to :tabela, foreign_key: :tabe_id
end
