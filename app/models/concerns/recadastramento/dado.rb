module Recadastramento
  class Dado
    attr_accessor :imovel, :cliente, :hidrometro

    def initialize imovel, cliente, hidrometro
      @imovel, @cliente, @hidrometro = imovel, cliente, hidrometro
    end
  end
end