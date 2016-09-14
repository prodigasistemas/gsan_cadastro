module Recadastramento
  module Arquivo
    class HidrometroMovimentacao < Recadastramento::Base
      attr_accessor :numero_hidrometro, :data_movimentacao, :hora_movimentacao,
                    :local_origem, :local_destino, :leitura_inicial, :motivo_movimentacao
    end
  end
end