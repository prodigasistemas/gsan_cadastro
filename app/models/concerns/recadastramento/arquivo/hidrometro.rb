module Recadastramento
  module Arquivo
    class Hidrometro < Recadastramento::Base
      attr_accessor :descricao_marca, :descricao_capacidade, :descricao_protecao, :possui_medidor

      def initialize(*args)
        @descricao_marca      = args[0].try(:descricao_marca)
        @descricao_capacidade = args[1].try(:descricao_capacidade)
        @descricao_protecao   = args[2].try(:descricao_protecao)

        @possui_medidor = possui_medidor?
      end

      def possui_medidor?
        descricao_marca.present? and descricao_capacidade.present? and descricao_protecao.present?
      end
    end
  end
end