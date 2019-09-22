class DocumentoEmissaoForma < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model
  
  TYPES = {
    :CRONOGRAMA           => 1,
    :EVENTUAL             => 2,
    :INDIVIDUAL           => 3,
    :IMPRESSAO_SIMULTANEA => 4
  }

  self.table_name  = 'cobranca.documento_emissao_forma'
  self.primary_key = 'demf_id'
  
  alias_attribute "id",                     "demf_id"
  alias_attribute "descricao",              "demf_dsdocumentoemissaoforma"
end  
