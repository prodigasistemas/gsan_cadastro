class Hidrometro < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'micromedicao.hidrometro'
  self.primary_key = 'hidr_id'

  alias_attribute "id", "hidr_id"
  alias_attribute "numero_hidrometro", "hidr_nnhidrometro"
  alias_attribute "data_aquisicao", "hidr_dtaquisicao"
  alias_attribute "ano_fabricacao", "hidr_nnanofabricacao"
  alias_attribute "indicador_macro", "hidr_icmacro"
  alias_attribute "ultima_revisao", "hidr_dtultimarevisao"
  alias_attribute "data_baixa", "hidr_dtbaixa"
  alias_attribute "numero_leitura_acumulada", "hidr_nnleituraacumulada"
  alias_attribute "numero_digitos_leitura", "hidr_nndigitosleitura"
  alias_attribute "hidrometro_classe_metrlg_id", "hicm_id"
  alias_attribute "hidrometro_marca_id", "himc_id"
  alias_attribute "hidrometro_diametro_id", "hidm_id"
  alias_attribute "hidrometro_local_armaz_id", "hila_id"
  alias_attribute "hidrometro_motivo_baixa_id", "himb_id"
  alias_attribute "hidrometro_situacao_id", "hist_id"
  alias_attribute "ultima_alteracao", "hidr_tmultimaalteracao"
  alias_attribute "hidrometro_capacidade_id", "hicp_id"
  alias_attribute "hidrometro_tipo_id", "hitp_id"
  alias_attribute "hidrometro_relojoaria_id", "hire_id"
  alias_attribute "vazao_transicao", "hidr_vztransicao"
  alias_attribute "vazao_nominal", "hidr_vznominal"
  alias_attribute "vazao_minima", "hidr_vzminima"
  alias_attribute "numero_tempo_garantia", "hidr_nntempogarantia"
  alias_attribute "numero_nota_fiscal", "hidr_nnnotafiscal"
  alias_attribute "hidrometro_class_pressao_id", "hcpr_id"
  alias_attribute "hidrometro_fat_correcao_id", "hifc_id"
  alias_attribute "numero_tombamento", "hidr_nntombamento"
  alias_attribute "indicador_operacional", "hidr_icoperacional"

  has_many :hidrometro_movimentados, foreign_key: "hidr_id"
  has_many :hidrometro_movimentacoes, through: :hidrometro_movimentados
  belongs_to :hidrometro_capacidade, foreign_key: "hicp_id"
  belongs_to :hidrometro_tipo, foreign_key: "hitp_id"
  belongs_to :hidrometro_marca, foreign_key: "himc_id"
  belongs_to :hidrometro_diametro, foreign_key: "hidm_id"
  belongs_to :hidrometro_relojoaria, foreign_key: "hire_id"
end