module Recadastramento
  module Arquivo
    class Cliente < Recadastramento::Base
      attr_accessor :id, :nome, :tipo_pessoa

      alias_attribute :matricula_usuario, :id
      alias_attribute :nome_usuario, :nome
    end
  end
end