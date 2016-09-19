module Recadastramento
  class TestDadosHidrometro
    def self.gerar_para(localidade, data_inicial, data_final)
      historico = HidrometroInstalacaoHistorico.por_localidade_e_intervalo(localidade, data_inicial, data_final)

      dados = historico.map{ |hist| Recadastramento::DadoHidrometroInstalacaoHistorico.new(hist) }

      Recadastramento::GeradorCSV.new(dados, "hidrometro_31082016-3").gerar
    end
  end
end