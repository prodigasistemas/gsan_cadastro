module Recadastramento
  module Arquivo
    class Cliente < Recadastramento::Base
      attr_accessor :nome, :tipo_pessoa, :cpf_cnpj, :rg, :uf, :tipo_sexo, :telefone
    end
  end
end