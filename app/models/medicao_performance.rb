class MedicaoPerformance < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'desempenho.medicao_performance'
  self.primary_key = 'medp_id'

  alias_attribute "id",                             "medp_id"
  alias_attribute "criado_em",                      "medp_tmcriacao"
  alias_attribute "ano_mes_referencia",             "medp_referencia"
  alias_attribute "valor_diferenca_agua",           "medp_vldiferencaagua"
  alias_attribute "diferenca_consumo_agua",         "medp_difconsumoagua"
  alias_attribute "consumo_mes_zero",               "medp_consumomeszero"
  alias_attribute "consumo_referencia",             "medp_consumoreferencia"
  alias_attribute "valor_agua_faturado",            "medp_vlaguafaturado"
  alias_attribute "valor_agua_faturado_mes_zero",   "medp_vlaguafaturadomeszero"
  alias_attribute "calculo",                        "medp_calculo"
  alias_attribute "debito_credito_situacao_id",     "dcst_id"
  alias_attribute "contrato_medicao_id",            "cmed_id"
  alias_attribute "imovel_id",                      "imov_id"


  belongs_to :contrato_medicao, foreign_key: :cmed_id
  belongs_to :imovel,           foreign_key: :imov_id
  belongs_to :debito_credito_situacao, foreign_key: :dcst_id, optional: true
  has_many   :abrangencias, through: :contrato_medicao

  def abrangencia
    @abrangencia ||= abrangencias.find_by(imovel_id: imovel_id)
  end

  def situacao_ligacao_atual
    imovel.ligacao_agua_situacao.descricao
  end

  def situacao_ligacao_inicial
    abrangencia.ligacao_agua_situacao.descricao
  end

  def situacao
    if debito_credito_situacao_id == DebitoCreditoSituacao::SITUACAO[:normal] ||
       debito_credito_situacao_id == DebitoCreditoSituacao::SITUACAO[:incluida] ||
       debito_credito_situacao_id == DebitoCreditoSituacao::SITUACAO[:retificada]
      '1. Faturado'
    else
      '2. Cancelado'
    end
  end

  def economias_atuais_imovel
    subcategorias = ImovelSubcategoria.where(imov_id: imov_id)

    retorno = ""

    subcategorias.each do |sub|
      retorno += sub.subcategoria.descricao + "=" + sub.qtd_economias.to_s + " "
    end

    retorno
  end

  def economias_iniciais_imovel
    subcategorias = ImovelSubcategoriaAbrangencia.where(imov_id: imov_id)

    retorno = ""

    subcategorias.each do |sub|
      retorno += sub.subcategoria.descricao + "=" + sub.qtd_economias.to_s + " "
    end

    retorno
  end

  def self.filtrar(params={})
    medicoes = all

    if params['referencia'].present?
      medicoes = where('medicao_performance.medp_referencia = ?', params['referencia'])
    end

    if params[:contrato_medicao_id]
      medicoes = medicoes.joins(:contrato_medicao).
         where("contrato_medicao.cmed_id = ?", params[:contrato_medicao_id])
    end

    if params[:localidade_id].present?
      medicoes = medicoes.joins(:imovel).
         where("imovel.loca_id = ?",        params[:localidade_id])
    end

    if params[:setor_comercial_id].present?
      medicoes =medicoes.joins(:imovel).
         where("imovel.stcm_id = ?",        params[:setor_comercial_id])
    end

    if params[:rota_id].present?
      medicoes = medicoes.joins(imovel: :quadra).
         where("quadra.rota_id = ?", params[:rota_id]);
    end

    medicoes
  end
end