class AtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Model

  DISPONIVEL = 0
  BLOQUEADO = 1
  EM_CAMPO = 2
  TRANSMITIDO = 3
  APROVADO = 4
  EM_FISCALIZACAO = 5
  ATUALIZADO = 6

  TODOS = "2"
  PENDENTES = "1"
  APROVADOS = "0"

  self.table_name  = 'seguranca.tab_atlz_cadastral'
  self.primary_key = 'tatc_id'

  alias_attribute :id,                         :tatc_id
  alias_attribute :tabela_id,                  :tabe_id
  alias_attribute :leiturista_id,              :leit_id
  alias_attribute :arquivo_texto_atlz_cad_id,  :txac_id
  alias_attribute :codigo_imovel,              :tatc_cdimovel
  alias_attribute :codigo_cliente,             :tatc_cdcliente

  has_many :coluna_atualizacao_cadastrais, foreign_key: :tatc_id

  def self.buscar_atualizacoes_para_recadastramento(params)
    query = <<-SQL
      select
        distinct tatc.tatc_cdimovel as codigo_imovel,
        tatc.altp_id as tipoAlteracao,
        func.func_nmfuncionario as agente_cadastral,
        siac_dssituacao as situacao
      from seguranca.tab_atlz_cadastral tatc                                                                -- TEM
      inner join seguranca.operacao_efetuada opef on opef.opef_id = tatc.opef_id                            -- NAO ****
      inner join seguranca.tab_col_atlz_cadastral tcac on  tatc.tatc_id = tcac.tatc_id                      -- TEM
      inner join seguranca.tabela_coluna tbco on tbco.tbco_id = tcac.tbco_id                                -- TEM
      inner join cadastro.arquivo_texto_atlz_cad txac on tatc.txac_id = txac.txac_id                        -- TEM
      inner join micromedicao.rota rota on rota.rota_id = txac.rota_id                                      -- TEM
      inner join micromedicao.leiturista leit on tatc.leit_id = leit.leit_id                                -- TEM
      left join cadastro.funcionario func on leit.func_id = func.func_id                                    -- NAO ****
      left join cadastro.cliente clie on leit.clie_id = clie.clie_id                                        -- TEM
      left join atualizacaocadastral.imovel_controle_atlz_cad ctrl on ctrl.imov_id = tatc.tatc_cdimovel     -- TEM
      left join cadastro.situacao_atlz_cadastral siac on siac.siac_id = ctrl.siac_id                        -- TEM
      left join cadastro.imovel_atlz_cadastral im on im.imov_id = tatc_cdimovel                             -- TEM
      left join cadastro.imovel_subcatg_atlz_cad isac on isac.imov_id = tatc.tatc_cdimovel                  -- TEM
      left join cadastro.cadastro_ocorrencia cocr on cocr.cocr_id = ctrl.cocr_id                            -- TEM
      where 1 = 1
    SQL
    query << "and leit.empr_id = #{params[:empresa_id]}"
    query << "\nand txac.loca_id between #{params[:localidade_id_inicial]} and #{params[:localidade_id_final]}" unless params[:localidade_id_inicial].blank?
    query << "\nand txac.txac_cdsetorcomercial between #{params[:setor_comercial_id_inicial]} and #{params[:setor_comercial_id_final]}" unless params[:setor_comercial_id_inicial].blank?
    query << "\nand rota.rota_cdrota between #{params[:rota_id_inicial]} and #{params[:rota_id_final]}" unless params[:rota_id_inicial].blank?

    if params[:exibir_imoveis] and params[:exibir_imoveis] != TODOS
      situacoes = "#{TRANSMITIDO}"
      if params[:exibir_imoveis] != PENDENTES
        query << "\nand tcac.tcac_dtvalidacao is null"
        situacoes << ", #{TRANSMITIDO}"
      elsif params[:exibir_imoveis] != APROVADOS
        query << "\nand tcac.tcac_dtvalidacao is not null"
        situacoes << ", #{APROVADO}, #{EM_FISCALIZACAO}"
      end
      query << "\nand ctrl.siac_id in (#{situacoes})"
    else
      query << "\nand ctrl.siac_id not in (#{ATUALIZADO})"
    end

    if %w(1 0).include?(params[:ocorrencias_cadastro])
      query << "\nand cocr.cocr_icvalidacao = #{params[:ocorrencias_cadastro]}"
    end

    query << "\norder by tatc.tatc_cdimovel"

    ActiveRecord::Base.connection.execute(query)
  end
end
