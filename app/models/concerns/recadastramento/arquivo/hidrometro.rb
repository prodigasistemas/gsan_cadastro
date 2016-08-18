module Recadastramento
  module Arquivo
    class Hidrometro < Recadastramento::Base
      attr_accessor :marca_hidrometro, :capacidade_hidrometro, :protecao_hidrometro

      def possui_medidor
        marca_hidrometro.present? and capacidade_hidrometro.present? and protecao_hidrometro.present?
      end
    end
  end
end