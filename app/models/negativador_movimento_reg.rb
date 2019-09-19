class NegativadorMovimentoReg < ActiveRecord::Base
  self.table_name  = 'cobranca.negatd_movimento_reg'
  self.primary_key = 'nmrg_id'

  alias_attribute "id",                      "nmrg_id"
  alias_attribute "codigoExclusaoTipo",      "nmrg_cdexclusaotipo"
  alias_attribute "regInclusao",             "nmrg_idreginclusao"
  alias_attribute "aceito",                  "nmrg_icaceito"
  alias_attribute "ngmv_id",                 "ngmv_id"
  alias_attribute "imov_id",                 "imov_id"

  belongs_to :imovel,                        foreign_key: :imov_id
  belongs_to :negativador_movimento,         foreign_key: :ngmv_id

  def self.totalizador
    # TODO: Mapear os outros models que estão no join
    select(select_negativacoes)
      .joins("INNER JOIN cobranca.negativador_movimento ngmv ON ngmv.ngmv_id = negatd_movimento_reg.ngmv_id")
      .joins("INNER JOIN cobranca.negativacao_imoveis   ngim ON ngim.ngcm_id = ngmv.ngcm_id AND ngim.imov_id = negatd_movimento_reg.imov_id")
      .joins("INNER JOIN cobranca.negativador_contrato  ngcn ON ngcn.negt_id = ngmv.negt_id AND (ngcn_dtcontratoencerramento IS NULL OR ngcn_dtcontratofim >= NOW())")
      .joins("INNER JOIN cobranca.negativador           negt ON negt.negt_id = ngmv.negt_id")
      .joins("INNER JOIN cadastro.cliente               clie ON clie.clie_id = negt.clie_id")
      .where("negatd_movimento_reg.nmrg_icaceito = :indicador_aceito and nmrg_idreginclusao IS NULL", indicador_aceito: 1)
      .group(agrupamento_negativacoes)
      .order("1,2")
  end

  private

  def self.select_negativacoes
    <<-SQL
      clie.clie_nmcliente as nome_cliente,
      #{indicador_negativacao_confirmada} as indicador_negativacao_confirmada,
      count(*) as total
    SQL
  end

  def self.agrupamento_negativacoes
    <<-SQL
      clie.clie_nmcliente, #{indicador_negativacao_confirmada}
    SQL
  end

  def self.indicador_negativacao_confirmada
    <<-SQL
      case
        when negatd_movimento_reg.nmrg_cdexclusaotipo is not null
        then
          case
            when ngim_dtexclusao - ngmv_dtprocessamentoenvio > ngcn_nnprazoinclusao
            then 1
            else 2
          end
      else
        case
          when NOW() - ngmv_dtprocessamentoenvio > ngcn_nnprazoinclusao
          then 1
          else 2
        end
      end
    SQL
  end
end