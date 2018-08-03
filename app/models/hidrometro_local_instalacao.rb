class HidrometroLocalInstalacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro_local_inst'
  self.primary_key = 'hili_id'

  alias_attribute :id,                         :hili_id
  alias_attribute :descricao,                  :hili_dshidmtlocalinstalacao
  alias_attribute :descricao_abreviada,        :hili_dsabrvhidmtlocinstalacao
  alias_attribute :indicador_uso,              :hili_icuso
  alias_attribute :ultima_alteracao,           :hili_tmultimaalteracao

end
