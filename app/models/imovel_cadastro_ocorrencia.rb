class ImovelCadastroOcorrencia < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.imovel_cad_ocorrencia'
  self.primary_key = 'icor_id'

  alias_attribute "id",                 "icor_id"
  alias_attribute "data_ocorrencia",    "icor_dtocorrenciacadastro"
  alias_attribute "foto_ocorrencia",    "icor_fotoocorrenciacadastro"
  alias_attribute "ultima_alteracao",   "icor_tmultimaalteracao"
  alias_attribute "cocr_id",            "cocr_id"
  alias_attribute "imovel",             "imov_id"

  belongs_to  :cadastro_ocorrencia,          foreign_key: :cocr_id,  class_name: 'CadastroOcorrencia'
  delegate :elo_anormalidade,  :to => :imovel, :allow_nil => true, :prefix => true
end