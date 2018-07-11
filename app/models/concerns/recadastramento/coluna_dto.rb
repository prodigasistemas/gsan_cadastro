module Recadastramento
  class ColunaDto
    attr_accessor :id,
                  :tabela,
                  :campo,
                  :valor_anterior,
                  :valor_atual,
                  :data_ultima_atualizacao,
                  :nome_usuario

    def initialize(coluna_atualizacao_cadastral)
      @id = coluna_atualizacao_cadastral.id
      @tabela = coluna_atualizacao_cadastral.tabela_coluna_id
      @campo = coluna_atualizacao_cadastral.try(:tabela_coluna).try(:descricao_coluna)
      @valor_anterior = coluna_atualizacao_cadastral.valor_anterior
      @valor_atual = coluna_atualizacao_cadastral.valor_atual
      @data_ultima_atualizacao = coluna_atualizacao_cadastral.data_ultima_atualizacao
      @nome_usuario = coluna_atualizacao_cadastral.try(:usuario).try(:nome)
    end
  end
end
