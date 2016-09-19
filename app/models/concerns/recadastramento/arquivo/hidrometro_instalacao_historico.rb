module Recadastramento
  module Arquivo
    class HidrometroInstalacaoHistorico < Recadastramento::Base
      attr_accessor :numero_hidrometro, :data_instalacao, :data_retirada,
                    :matricula_imovel, :numero_leitura_instalacao, :numero_leitura_retirada
    end
  end
end