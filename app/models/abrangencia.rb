class Abrangencia < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'desempenho.contrato_medicao_abrangencia'
  self.primary_key = 'cmab_id'

  alias_attribute "id",                        "cmab_id"
  alias_attribute "criado_em",                 "cmab_tmcriacao"
  alias_attribute "atualizado_em",             "cmab_tmultimaalteracao"
  alias_attribute "contrato_medicao_id",       "cmed_id"
  alias_attribute "imovel_id",                 "imov_id"
  alias_attribute "ligacao_agua_situacao_id",  "last_id"
  alias_attribute "percentual_esgoto",         "cmab_pcesgoto"

  belongs_to :contrato_medicao,      foreign_key: 'cmed_id'
  belongs_to :imovel,                foreign_key: 'imov_id'
  belongs_to :ligacao_agua_situacao, foreign_key: 'last_id'
  has_many   :coeficientes, through: :contrato_medicao

  def self.criar(contrato_medicao, imoveis_ids)
    abrangencia_attrs = []

    imoveis_ids.each do |id|
      conta = Conta.do_imovel_com_referencia(id, contrato_medicao.referencia_assinatura)

      abrangencia_attrs << {
        cmed_id: contrato_medicao.id,
        imov_id: id,
        cmab_tmcriacao: Time.zone.now,
        cmab_tmultimaalteracao: Time.zone.now,
        last_id: conta.ligacao_agua_situacao_id,
        cmab_pcesgoto: conta.percentual_esgoto
      }
    end

    self.inserir_varios(abrangencia_attrs)
  end

  def coeficiente
    @coeficiente ||= coeficientes.find_by(ligacao_agua_situacao: ligacao_agua_situacao)
  end

  def excluir
    return unless self.destroy

    HistoricoAbrangencia.create({
      criado_em: self.criado_em,
      removido_em: Time.zone.now,
      contrato_medicao_id: self.contrato_medicao_id,
      imovel_id: self.imovel_id,
    })
  end
end