module Recadastramento
  module Arquivo
    class Hidrometro < Recadastramento::Base
      attr_accessor :descricao_marca, :descricao_capacidade, :descricao_protecao

      def possui_medidor
        descricao_marca.present? and descricao_capacidade.present? and descricao_protecao.present?
      end
    end
  end
end