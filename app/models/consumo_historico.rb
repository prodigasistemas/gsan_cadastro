class ConsumoHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.consumo_historico'
  self.primary_key = 'cshi_id'

  alias_attribute "id",                                   "cshi_id"
  alias_attribute "referencia_faturamento",               "cshi_amfaturamento"
  alias_attribute "indicador_alteracao_ultimos_consumos", "cshi_icaltultimosconss"
  alias_attribute "indicador_ajuste",                     "cshi_icajuste"
  alias_attribute "numero_consumo_faturado_mes",          "cshi_nnconsumofaturadomes"
  alias_attribute "consumo_rateio",                       "cshi_nnconsumorateio"
  alias_attribute "indicador_imovel_condominio",          "cshi_icimovelcondominio"
  alias_attribute "consumo_medio",                        "cshi_nnconsumomedio"
  alias_attribute "consumo_minimo",                       "cshi_nnconsumominimo"
  alias_attribute "indicador_faturamento",                "cshi_icfaturamento"
  alias_attribute "percentual_coleta",                    "cshi_pccoleta"
  alias_attribute "ultima_alteracao",                     "cshi_tmultimaalteracao"
  alias_attribute "consumo_imovel_condominio",            "cshi_idconsumoimovelcondominio"
  alias_attribute "consumo_imovel_vinculados_condominio", "cshi_nnconsimoveisvinculados"
  alias_attribute "numero_consumo_calculo_media",         "cshi_nnconsumocalculomedia"

  alias_attribute "ligacao_tipo_id",                      "lgti_id"

  belongs_to :consumo_anormalidade, foreign_key: :csan_id, class_name: "ConsumoAnormalidade"
  belongs_to :consumo_tipo, foreign_key: :cstp_id, class_name: "ConsumoTipo"
  
end