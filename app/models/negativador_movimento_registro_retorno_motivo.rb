class NegativadorMovimentoRegistroRetornoMotivo < ActiveRecord::Base
  self.table_name  = 'cobranca.negatd_mov_reg_ret_mot'
  self.primary_key = 'nmrr_id'

  alias_attribute "id", "nmrr_id"

  belongs_to :negativador_movimento_reg,  foreign_key: :nmrg_id
  belongs_to :negativador_retorno_motivo, foreign_key: :nrmt_id

  def self.por_imovel(imovel_id)
      joins(negativador_movimento_reg: [:negativador_movimento])
      .where("cobranca.negatd_movimento_reg.imov_id = #{imovel_id}")
      .where("cobranca.negatd_movimento_reg.nmrg_icaceito = :indicador" , indicador: 2)
      .where("negativador_movimento.ngmv_cdmovimento = :codigo", codigo: 1)
      .order("negativador_movimento.ngmv_dtretorno DESC")
  end
end