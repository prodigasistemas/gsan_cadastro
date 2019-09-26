class ConsumoTarifa < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'faturamento.consumo_tarifa'
    self.primary_key = 'cstf_id'
  
    alias_attribute "id", "cstf_id"
    alias_attribute "descricao", "cstf_dsconsumotarifa"
    alias_attribute "ultima_alteracao", "cstf_tmultimaalteracao"
    alias_attribute "indicador_uso", "cstf_icemitido"
    alias_attribute "ligacaoAguaPerfil", "lapf_id"
    alias_attribute "tarifaTipoCalculo", "ttpc_id"
  end
  
