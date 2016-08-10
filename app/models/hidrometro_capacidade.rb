class HidrometroCapacidade < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_capacidade'
  self.primary_key = 'hicp_id'

  alias_attribute "id", "hicp_id"
  alias_attribute "descricao_capacidade", "hicp_dshidrometrocapacidade"
  alias_attribute "abreviacao", "hicp_dsabreviadahidrcapacidade"
  alias_attribute "leitura_minima", "hicp_nndigitosleituraminimo"
  alias_attribute "leitura_maxima", "hicp_nndigitosleituramaximo"
  alias_attribute "indicador_uso", "hicp_icuso"
  alias_attribute "ultima_alteracao", "hicp_tmultimaalteracao"
  alias_attribute "ordem", "hicp_nnordem"
  alias_attribute "codigo_capacidade", "hicp_cdhidrometrocapacidade"
end