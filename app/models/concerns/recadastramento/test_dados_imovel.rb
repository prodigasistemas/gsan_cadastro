module Recadastramento
  class TestDadosImovel

    def gerar_para(empresa, limit = 10)
      return unless empresa

      inclusoes = [:hidrometro_marca, :hidrometro_capacidade, :hidrometro_protecao,
        :cliente_retornos, :fonte_abastecimento, :ramal_local_instalacao,
        :imovel_tipo_ocupante_quantidade_retornos, :situacao_atualizacao_cadastral]

      irs = []
      if limit.present? and limit > 0
        irs = empresa.imovel_retornos.includes(inclusoes).limit(limit)
      else
        irs = empresa.imovel_retornos.includes(inclusoes)
      end

      dados = irs.map{ |ir| Recadastramento::DadoImovelRetorno.new(ir) }

      Recadastramento::GeradorCSV.new(dados, "imovel_retorno_31082016-3").gerar
    end
  end
end