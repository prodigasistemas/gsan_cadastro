module Recadastramento
  class TestDadosHidrometro
    def self.gerar_para(data_inicial, data_final, options={})
      options[:data_inicial] = data_inicial
      options[:data_final] = data_final

      historico = HidrometroInstalacaoHistorico.filtrar_por(options)

      dados = historico.map{ |hist| Recadastramento::DadoHidrometroInstalacaoHistorico.new(hist) }

      Recadastramento::GeradorCSV.new(dados, "hidrometro_test").gerar
    end
  end
end