module Recadastramento
  class ReprovadoDto

    def initialize(params)
      @lote = params["lote"]
      @imovel_id = params["imovel_id"]
      @ocorrencia_cadastro = params["ocorrencia_cadastro"]
      @agente_cadastral = params["agente_cadastral"]
      @data_hora_reprovacao = params["data_hora_reprovacao"]
    end
  end
end