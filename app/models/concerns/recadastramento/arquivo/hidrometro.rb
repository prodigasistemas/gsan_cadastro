module Recadastramento
  module Arquivo
    class Hidrometro < Recadastramento::Base
      attr_accessor :hidrometro_marca, :hidrometro_capacidade, :hidrometro_protecao

      def possui_medidor
        hidrometro_marca.present? and hidrometro_capacidade.present? and hidrometro_protecao.present?
      end
    end
  end
end