module Recadastramento
  module Arquivo
    class HidrometroMovimentacao < Recadastramento::Base
      attr_accessor :data_movimentacao, :hora_movimentacao, :descricao
    end
  end
end