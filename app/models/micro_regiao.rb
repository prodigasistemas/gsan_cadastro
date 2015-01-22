class MicroRegiao < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.microrregiao'
  self.primary_key = 'mreg_id'

  alias_attribute "id",             "mreg_id"
  alias_attribute "nome",           "mreg_nmmicrorregiao"
  alias_attribute "regiao_id",      "regi_id"
  alias_attribute "ativo",          "mreg_icuso"
  alias_attribute "atualizado_em",  "mreg_tmultimaalteracao"

  validates_uniqueness_of :nome
  validates_presence_of :regiao
  validates_inclusion_of :ativo, in: [1,2]

  belongs_to :regiao, foreign_key: :regi_id

  default_scope -> { order(:nome) }
  scope :ativos, -> { where ativo: 1 }
end
