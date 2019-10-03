class MedicaoHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.medicao_historico'
  self.primary_key = 'mdhi_id'

  alias_attribute "id",                                                "mdhi_id"
  alias_attribute "ano_mes_referencia",                                "mdhi_amleitura"
  alias_attribute "numero_vezes_consecutivas_ocorrencia_anormalidade", "mdhi_nnxconsecanormalidade"
  alias_attribute "data_leitura_anterior_faturamento",                 "mdhi_dtleitantfatmt"
  alias_attribute "leitura_anterior_faturamento",                      "mdhi_nnleitantfatmt"
  alias_attribute "leitura_anterior_informada",                        "mdhi_nnleitantinformada"
  alias_attribute "data_leitura_atual_informada",                      "mdhi_dtleituraatualinformada"
  alias_attribute "leitura_atual_informada",                           "mdhi_nnleituraatualinformada"
  alias_attribute "data_leitura_atual_faturamento",                    "mdhi_dtleituraatualfaturamento"
  alias_attribute "leitura_atual_faturamento",                         "mdhi_nnleituraatualfaturamento"
  alias_attribute "numero_consumo_mes",                                "mdhi_nnconsumomedidomes"
  alias_attribute "numero_consumo_informado",                          "mdhi_nnconsumoinformado"
  alias_attribute "ultima_alteracao",                                  "mdhi_tmultimaalteracao"
  alias_attribute "consumo_medio_hidrometro",                          "mdhi_nnconsumomediohidrometro"
  alias_attribute "indicador_analisado",                               "mdhi_icanalisado"
  alias_attribute "leitura_campo",                                     "mdhi_nnleituracampo"
  alias_attribute "data_leitura_campo",                                "mdhi_dtleituracampo"
  alias_attribute "leitura_processamento_movimento",                   "mdhi_dtleitprocessamentomov"
  alias_attribute "ligacao_agua_id",                                   "lagu_id"
  alias_attribute "funcionario_id",                                    "func_id"

  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :leitura_situacao, foreign_key: :ltst_idleiturasituacaoatual, class_name: "LeituraSituacao"
  belongs_to :leitura_anormalidade_informada, foreign_key: :ltan_idleitanorminformada, class_name: "LeituraAnormalidade"
  belongs_to :leitura_anormalidade_faturamento, foreign_key: :ltan_idleitanormfatmt, class_name: "LeituraAnormalidade"
end