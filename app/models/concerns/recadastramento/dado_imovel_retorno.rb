module Recadastramento
  class DadoImovelRetorno
    attr_accessor :imovel, :cliente_usuario, :cliente_responsavel, :cliente_proprietario, :hidrometro

    def initialize imovel_retorno
      @imovel = Recadastramento::Arquivo::Imovel.new imovel_retorno
      @hidrometro = Recadastramento::Arquivo::Hidrometro.new imovel_retorno.hidrometro_marca,
                                                             imovel_retorno.hidrometro_capacidade,
                                                             imovel_retorno.hidrometro_protecao
      @cliente_usuario = Recadastramento::Arquivo::Cliente.new imovel_retorno.cliente_usuario_retorno
      @cliente_responsavel = Recadastramento::Arquivo::Cliente.new imovel_retorno.cliente_responsavel_retorno
      @cliente_proprietario = Recadastramento::Arquivo::Cliente.new imovel_retorno.cliente_proprietario_retorno
    end
  end
end