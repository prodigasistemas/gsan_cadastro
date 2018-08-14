module Recadastramento
  class ColunaDto
    MODELOS = { last_id: "LigacaoAguaSituacao",
                est_id: "LigacaoEsgotoSituacao",
                tab_id: "FonteAbastecimento",
                rtp_id: "ClienteRelacaoTipo",
                ltp_id: "ClienteTipo",
                rof_id: "Profissao",
                atv_id: "RamoAtividade",
                dtp_id: "EnderecoTipo",
                drf_id: "EnderecoReferencia",
                net_id: "FoneTipo",
                ocr_id: "CadastroOcorrencia",
                icp_id: "HidrometroCapacidade",
                imc_id: "HidrometroMarca",
                ili_id: "HidrometroLocalInstalacao",
                ipr_id: "HidrometroProtecao",
                lin_id: "RamalLocalInstalacao",
                ftab_id: "FonteAbastecimento",
                cocr_id: "CadastroOcorrencia",
                rlin_id: "RamalLocalInstalacao",
                lcla_id: "LocalidadeClasse",
                crtp_id: "ClienteRelacaoTipo",
                psex_id: "PessoaSexo",
                lest_id: "LigacaoEsgotoSituacao" }

    ENUMS = { imac_classe_social: "CLASSES_SOCIAIS",
              imac_tipo_uso: "TIPO_USO_IMOVEL",
              imac_acesso_hidrometro: "ACESSO_HIDROMETRO" }

    CLASSES_SOCIAIS = { "1": "ALTA",
                       "2": "MEDIA",
                       "3": "BAIXA",
                       "4": "SUB" }

    TIPO_USO_IMOVEL = { "1": "DORMITORIO",
                        "2": "MORADA",
                        "3": "VERANEIO",
                        "4": "OUTROS" }

    ACESSO_HIDROMETRO = { "1": "BOM",
                          "2": "RUIM",
                          "3": "SEM" }

    NOME_COLUNA_ECONOMIAS = "isac_qteconomia"

    attr_accessor :id,
                  :tabela,
                  :campo,
                  :valor_anterior,
                  :valor_atual,
                  :data_ultima_atualizacao,
                  :nome_usuario,
                  :valor_revisado,
                  :valor_pre_aprovado


    def initialize(coluna_atualizacao_cadastral)
      @id = coluna_atualizacao_cadastral.id
      if subcategoria?(coluna_atualizacao_cadastral.try(:tabela_coluna).try(:nome_coluna))
        @tabela = "Subcateg. #{coluna_atualizacao_cadastral.try(:atualizacao_cadastral).try(:complemento)}"
        @campo = "Quantidade de Economias"
      else
        @tabela = coluna_atualizacao_cadastral.try(:tabela_coluna).try(:tabela).try(:descricao)
        @campo = coluna_atualizacao_cadastral.try(:tabela_coluna).try(:descricao_coluna)
      end
      @valor_anterior = ColunaDto.descricao_campo(coluna_atualizacao_cadastral.try(:tabela_coluna).try(:nome_coluna),
                                                  coluna_atualizacao_cadastral.valor_anterior)
      @valor_atual = ColunaDto.descricao_campo(coluna_atualizacao_cadastral.try(:tabela_coluna).try(:nome_coluna),
                                               coluna_atualizacao_cadastral.valor_atual)
      @valor_revisado = ColunaDto.descricao_campo(coluna_atualizacao_cadastral.try(:tabela_coluna).try(:nome_coluna),
                                               coluna_atualizacao_cadastral.valor_revisado)
      @valor_pre_aprovado = ColunaDto.descricao_campo(coluna_atualizacao_cadastral.try(:tabela_coluna).try(:nome_coluna),
                                               coluna_atualizacao_cadastral.valor_pre_aprovado)
      @data_ultima_atualizacao = coluna_atualizacao_cadastral.data_ultima_atualizacao
      @nome_usuario = coluna_atualizacao_cadastral.try(:usuario).try(:nome)
    end

    def self.descricao_campo(campo, valor)
      return nil if campo.blank? or valor.blank?
      return MODELOS[campo.to_sym].constantize.find_by(id: valor).try(:descricao) || valor if MODELOS.key?(campo.to_sym)
      return ColunaDto.const_get(ENUMS[campo.to_sym])[valor.to_sym] || valor if ENUMS.key?(campo.to_sym)
      valor
    end

    private
      def subcategoria?(campo)
        NOME_COLUNA_ECONOMIAS.eql?(campo)
      end
  end
end

