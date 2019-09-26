class OrdemServico < ActiveRecord::Base
  include IncrementableId
  include Filterable
  
  self.table_name  = 'atendimentopublico.ordem_servico'
  self.primary_key = 'orse_id'

  NOMES_SITUACAO = {
    1 => "Pendente",
    2 => "Encerrada",
    3 => "Execução em andamento",
    4 => "Aguardando Liberação" 
  }

  alias_attribute "id",                 "orse_id"
  alias_attribute "situacao",           "orse_cdsituacao"
  alias_attribute "cbdo_id",            "cbdo_id"

  belongs_to :cobranca_documento, foreign_key: :cbdo_id
end