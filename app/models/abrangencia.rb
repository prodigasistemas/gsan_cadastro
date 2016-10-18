class Abrangencia < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'desempenho.contrato_medicao_abrangencia'
  self.primary_key = 'cmab_id'

  alias_attribute "id",                  "cmab_id"
  alias_attribute "criado_em",           "cmab_tmcriacao"
  alias_attribute "atualizado_em",       "cmab_tmultimaalteracao"
  alias_attribute "contrato_medicao_id", "cmed_id"
  alias_attribute "imovel_id",           "imov_id"

  belongs_to :contrato_medicao, foreign_key: 'cmed_id'
  belongs_to :imovel,           foreign_key: 'imov_id'

  def self.criar(contrato_medicao, imoveis_ids)
    abrangencia_attrs = []

    imoveis_ids.each do |id|
      abrangencia_attrs << {
        cmed_id: contrato_medicao.id,
        imov_id: id,
        cmab_tmcriacao: Time.zone.now,
        cmab_tmultimaalteracao: Time.zone.now
      }
    end

    self.inserir_varios(abrangencia_attrs)
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