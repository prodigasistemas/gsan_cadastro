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

  belongs_to :imovel, foreign_key:  :imov_id
  belongs_to :consumo_anormalidade, foreign_key: :csan_id, class_name: "ConsumoAnormalidade"
  belongs_to :consumo_tipo, foreign_key: :cstp_id, class_name: "ConsumoTipo"
  
  def self.por_ligacao_agua(imovel_id)
    select(select_historico, select_complemento_agua)
      .joins("LEFT JOIN micromedicao.medicao_historico medicao_historico on micromedicao.consumo_historico.imov_id = medicao_historico.lagu_id AND micromedicao.consumo_historico.cshi_amfaturamento = medicao_historico.mdhi_amleitura")
      .joins("LEFT OUTER JOIN micromedicao.leitura_situacao leitura_situacao on medicao_historico.ltst_idleiturasituacaoatual = leitura_situacao.ltst_id")
      .joins("LEFT OUTER JOIN micromedicao.consumo_anormalidade consumo_anormalidade on consumo_historico.csan_id = consumo_anormalidade.csan_id")
      .joins("LEFT OUTER JOIN micromedicao.consumo_tipo consumo_tipo on consumo_historico.cstp_id = consumo_tipo.cstp_id")
      .joins("LEFT OUTER JOIN micromedicao.consumo_historico consumo_historico_esgoto on consumo_historico.imov_id = consumo_historico_esgoto.imov_id and consumo_historico.cshi_amfaturamento = consumo_historico_esgoto.cshi_amfaturamento and consumo_historico_esgoto.lgti_id = #{LigacaoTipo::MODELO[:ESGOTO]}")
      .joins("LEFT OUTER JOIN micromedicao.leitura_situacao leitura_situacao on medicao_historico.ltst_idleiturasituacaoatual = leitura_situacao.ltst_id")
      .joins("LEFT OUTER JOIN micromedicao.leitura_anormalidade leitura_anormalidade_informada on medicao_historico.ltan_idleitanorminformada=leitura_anormalidade_informada.ltan_id")
      .joins("LEFT OUTER JOIN micromedicao.leitura_anormalidade leitura_anormalidade_faturamento on medicao_historico.ltan_idleitanormfatmt=leitura_anormalidade_faturamento.ltan_id")
      .where(consumo_historico: { imov_id: imovel_id, lgti_id: LigacaoTipo::MODELO[:AGUA] }).order(referencia_faturamento: :desc)
  end

  def self.por_ligacao_esgoto(imovel_id)
    select(select_historico, select_complemento_esgoto)
      .joins("LEFT JOIN micromedicao.medicao_historico medicao_historico on micromedicao.consumo_historico.imov_id = medicao_historico.lagu_id AND micromedicao.consumo_historico.cshi_amfaturamento = medicao_historico.mdhi_amleitura")
      .joins("LEFT OUTER JOIN micromedicao.consumo_anormalidade consumo_anormalidade on consumo_historico.csan_id = consumo_anormalidade.csan_id")
      .joins("LEFT OUTER JOIN micromedicao.consumo_tipo consumo_tipo on consumo_historico.cstp_id = consumo_tipo.cstp_id")
      .where(consumo_historico: { imov_id: imovel_id, lgti_id: LigacaoTipo::MODELO[:ESGOTO] }).order(referencia_faturamento: :desc)
  end

  private

  def self.select_historico
    <<-SQL
      consumo_historico.cshi_amfaturamento,
      consumo_historico.cshi_nnconsumofaturadomes,
      consumo_anormalidade.csan_dsconsumoanormalidade   as consumo_anormalidade_descricao,
      consumo_tipo.cstp_dsabreviadaconsumotipo 		      as consumo_tipo_abreviado,
      medicao_historico.mdhi_dtleituraatualfaturamento  as data_leitura_atual,
      consumo_historico.cshi_nnconsumorateio,
      medicao_historico.ltan_idleitanormfatmt 		      as id_anormalidade,
      consumo_anormalidade.csan_dsabrvconsanormalidade  as consumo_anormalidade_abreviada, 
      consumo_historico.cshi_nnconsumocalculomedia, 
      consumo_historico.cshi_nnconsumomedio,
      medicao_historico.mdhi_dtleituraatualinformada   as data_leitura_informada,
      medicao_historico.mdhi_nnleituraatualinformada   as numero_leitura_informada,
      medicao_historico.mdhi_nnleituraatualfaturamento as numero_leitura_faturada
    SQL
  end  

  def self.select_complemento_agua
    <<-SQL
      medicao_historico.mdhi_nnconsumomedidomes 		    as consumo_medido,
      consumo_tipo.cstp_dsconsumotipo 				          as consumo_tipo_descricao, 
      medicao_historico.mdhi_dtleitantfatmt 			      as data_leitura_anterior,
      consumo_historico_esgoto.cshi_nnconsumofaturadomes as consumo_faturado_esgoto,
      medicao_historico.mdhi_nnconsumoInformado 		    as consumo_informado, 
      leitura_anormalidade_informada.ltan_id 			      as id_anormalidade_leituraInformada,
      leitura_anormalidade_faturamento.ltan_dsleituraanormalidade as descricao_anormalidade_leiturafa,
      leitura_situacao.ltst_dsleiturasituacao 		      as leitura_situacao, 
      consumo_anormalidade.csan_id 					            as id_anormalidade_consumo
    SQL
  end

  def self.select_complemento_esgoto
    <<-SQL
      null as consumo_medido,
      null as consumo_tipo_descricao, 
      null as data_leitura_anterior,
      null as consumo_faturado_esgoto,
      null as consumo_informado, 
      null as id_anormalidade_leituraInformada,
      null as descricao_anormalidade_leiturafa,
      null as leitura_situacao, 
      null as id_anormalidade_consumo
    SQL
  end
end

