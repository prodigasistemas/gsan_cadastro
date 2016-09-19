module Recadastramento
  class DadoHidrometroInstalacaoHistorico
    attr_accessor :hidrometro_instalacao_historico

    def initialize hidrometro_instalacao_historico
      @hidrometro_instalacao_historico = Recadastramento::Arquivo::HidrometroInstalacaoHistorico.new hidrometro_instalacao_historico
    end
  end
end