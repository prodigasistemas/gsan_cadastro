class Regiao < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.regiao'
  self.primary_key = 'regi_id'

  alias_attribute "id",             "regi_id"
  alias_attribute "nome",           "regi_nmregiao"
  alias_attribute "ativo",          "regi_icuso"
  alias_attribute "atualizado_em",  "regi_tmultimaalteracao"

  validates_uniqueness_of :nome
  validates_presence_of   :nome
  validates_inclusion_of :ativo, in: [1,2]

  scope :ativos, -> { where ativo: 1 }
  scope :nome,   -> (nome) { where("UPPER(regi_nmregiao) LIKE ?", "%#{nome.upcase}%") }
end
