class ComunicadoEmitirConta < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'faturamento.comunicado_emitir_conta'
    self.primary_key = 'cmec_id'
  
    alias_attribute "id", "cmec_id"
    alias_attribute "imovel_id", "imov_id"
    alias_attribute "referencia", "cmec_amreferencia"
    alias_attribute "data_geracao", "cmec_tmgeracao"
    alias_attribute "ultima_alteracao", "cmec_tmultimaalteracao"
    alias_attribute "tipo_comunicado", "cmec_tipo"
    alias_attribute "indicador_emitido", "cmec_icemitido"
    
    belongs_to :imovel, foreign_key: "imov_id"
  end
  