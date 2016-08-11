module Recadastramento
  module Arquivo
    class Cliente < Recadastramento::Base
      attr_accessor :id, :gerencia

      def matricula
        id
      end
    end
  end
end