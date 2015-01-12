class CepTipo < ActiveRecord::Base
  include IncrementableId

  self.table_name  = 'cadastro.cep_tipo'
  self.primary_key = 'cept_id'

  alias_attribute "id",            "cept_id"
  alias_attribute "descricao",     "cept_dsceptipo"
  alias_attribute "ativo",         "cept_icuso"
  alias_attribute "atualizado_em", "cept_tmultimaalteracao"

  scope :ativo, -> { where(ativo: true) }

  has_many :ceps, foreign_key: :cept_id
end
