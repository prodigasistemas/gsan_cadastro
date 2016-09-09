class ArquivoRecadastramentoJob
  include SuckerPunch::Job

  def perform(empresa, nome_arquivo, limit = 10)
    return unless empresa

      inclusoes = [:hidrometro_marca, :hidrometro_capacidade, :hidrometro_protecao,
        :cliente_retornos, :fonte_abastecimento, :ramal_local_instalacao,
        :imovel_tipo_ocupante_quantidade_retornos, :situacao_atualizacao_cadastral]

      irs = empresa.imovel_retornos.includes(inclusoes)

      dados = irs.map{ |ir| Recadastramento::Dado.new(ir) }

      Recadastramento::GeradorCSV.new(dados, nome_arquivo).gerar
  end
end
