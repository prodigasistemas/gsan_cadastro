module Recadastramento
  class Dado
    attr_accessor :imovel, :cliente_usuario, :cliente_responsavel, :cliente_proprietario, :hidrometro

    def initialize imovel, cliente_usuario, cliente_responsavel, cliente_proprietario, hidrometro
      @imovel, @cliente_usuario, @cliente_responsavel, @cliente_proprietario, @hidrometro = imovel, cliente_usuario, cliente_responsavel, cliente_proprietario, hidrometro
    end
  end
end