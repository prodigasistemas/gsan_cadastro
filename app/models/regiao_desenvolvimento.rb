class RegiaoDesenvolvimento < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.regiao_desenvolvimento'
  self.primary_key = 'rdes_id'

  alias_attribute "id",             "rdes_id"
  alias_attribute "nome",           "rdes_nmregiaodesenvolvimento"
  alias_attribute "ativo",          "rdes_icuso"
  alias_attribute "atualizado_em",  "rdes_tmultimaalteracao"

  validates_presence_of   :nome
  validates_uniqueness_of  :nome
  validates_inclusion_of  :ativo, in: [1, 2]

  default_scope             -> { order(:nome) }
  scope :nome,              -> (nome) { where("UPPER(rdes_nmregiaodesenvolvimento) LIKE ?", "%#{nome.upcase}%") }
end
