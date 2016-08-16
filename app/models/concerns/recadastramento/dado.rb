module Recadastramento
  class Dado
    attr_accessor :imovel, :cliente, :servico, :hidrometro

    def initialize imovel, cliente, servico, hidrometro
      @imovel, @cliente, @servico, @hidrometro = imovel, cliente, servico, hidrometro
    end
  end
end