class HidrometroInstalacaoHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model
  include Filtros::HidrometroFiltro

  self.table_name  = 'micromedicao.hidrometro_inst_hist'
  self.primary_key = 'hidi_id'

  alias_attribute "id", "hidi_id"
  alias_attribute "hidrometro_id", "hidr_id"
  alias_attribute "data_instalacao", "hidi_dtinstalacaohidrometro"
  alias_attribute "tipo_medicao_id", "medt_id"
  alias_attribute "rateio_tipo_id", "rttp_id"
  alias_attribute "local_instalacao_id", "hili_id"
  alias_attribute "protecao_hidrometro_id", "hipr_id"
  alias_attribute "numero_leitura_instalacao", "hidi_nnleitinstalacaohidmt"
  alias_attribute "data_retirada", "hidi_dtretiradahidrometro"
  alias_attribute "numero_leitura_retirada", "hidi_nnleitretiradahidmt"
  alias_attribute "data_instalacao_sistema", "hidi_dtinstalacaohidmtsistema"
  alias_attribute "numero_leitura_corte", "hidi_nnleituracorte"
  alias_attribute "indicador_cavalete", "hidi_iccavalete"
  alias_attribute "indicador_instalacao_substituicao", "hidi_icinstalacaosubstituicao"
  alias_attribute "numero_leitura_supressao", "hidi_nnleiturasupressao"
  alias_attribute "ultima_alteracao", "hidi_tmultimaalteracao"
  alias_attribute "imovel_id", "imov_id"
  alias_attribute "ligacao_agua_id", "lagu_id"
  alias_attribute "numero_selo", "hidi_nnselo"
  alias_attribute "indicador_troca_protecao", "hidi_ictrocaprotecao"
  alias_attribute "indicador_troca_registro", "hidi_ictrocaregistro"
  alias_attribute "usuario_instalacao_id", "usur_idinstalacao"
  alias_attribute "usuario_retirada_id", "usur_idretirada"
  alias_attribute "numero_lacre", "hidi_nnlacre"

  alias_attribute "numero_hidrometro", "hidrometro_numero"
  alias_attribute "matricula_imovel", "imovel_matricula"

  belongs_to :hidrometro, foreign_key: "hidr_id"
  belongs_to :imovel, foreign_key: "lagu_id"
  belongs_to :medicao_tipo, foreign_key: "medt_id"
  belongs_to :local_instalacao, foreign_key: "hili_id", class_name: 'HidrometroLocalInstalacao'
  belongs_to :hidrometro_protecao, foreign_key: "hipr_id", class_name: 'HidrometroProtecao'
  belongs_to :usuario_instalacao, foreign_key: 'usur_idinstalacao', class_name: 'Usuario'

  scope :data_instalacao_entre, -> (data_inicial, data_final) {
    where(hidi_dtinstalacaohidrometro: data_inicial.to_date.beginning_of_day..data_final.to_date.beginning_of_day)
  }

  scope :data_retirada_entre, -> (data_inicial, data_final) {
    where(hidi_dtretiradahidrometro: data_inicial.to_date.beginning_of_day..data_final.to_date.beginning_of_day)
  }

  def hidrometro_numero
    hidrometro.try(:numero_hidrometro)
  end

  def imovel_matricula
    imovel.try(:id)
  end
end