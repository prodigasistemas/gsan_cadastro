class LigacaoEsgoto < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name = 'atendimentopublico.ligacao_esgoto'
  self.primary_key = 'lesg_id'

  alias_attribute "id", "lesg_id"
  alias_attribute "data_ligacao",      "lesg_dtligacao"
  alias_attribute "consumo_minimo",   "lesg_nnconsumominimoesgoto"
  alias_attribute "percentual", "lesg_pcesgoto" 
  alias_attribute "percentual_agua_consumida_coletada", "lesg_pccoleta"
  alias_attribute "indicador_caixa_gordura", "lesg_iccaixagordura"
  alias_attribute "indicador_ligacao_esgoto", "lesg_icligacaoesgoto"
  alias_attribute "ultima_alteracao", "lesg_tmultimaalteracao" 
  alias_attribute "percentual_alternativo", "lesg_pcalternativo" 
  alias_attribute "numeroConsumo_percentual_alternativo", "lesg_nnconsumopcalternativo" 
  
  has_one :imovel, foreign_key: :imov_id, class_name: 'Imovel'

  belongs_to :ligacao_esgoto_diametro, foreign_key: :legd_id, class_name: "LigacaoEsgotoDiametro"
  belongs_to :ligacao_esgoto_material, foreign_key: :legm_id, class_name: "LigacaoEsgotoMaterial"
  belongs_to :ligacao_esgoto_perfil, foreign_key: :lepf_id, class_name: "LigacaoEsgotoPerfil"

  belongs_to :ligacao_esgoto_esgotamento, foreign_key: :lees_id, class_name: "LigacaoEsgotoEsgotamento"
  belongs_to :ligacao_esgoto_caixa_inspecao, foreign_key: :leci_id, class_name: "LigacaoEsgotoCaixaInspecao"
  belongs_to :ligacao_esgoto_destino_dejetos, foreign_key: :ledd_id, class_name: "LigacaoEsgotoDestinoDejetos"
  belongs_to :ligacao_esgoto_destino_aguas_pluviais, foreign_key: :leda_id, class_name: "LigacaoEsgotoDestinoAguasPluviais"

  # belongs_to :hidrometro_instalacao_historico, foreign_key: :hidi_id, class_name: "HidrometroInstalacaoHistorico"
end