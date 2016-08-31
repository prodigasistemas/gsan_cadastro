module Recadastramento
  class TestDados

    def gerar_para(empresa, limit = 10)
      return unless empresa

      inclusoes = [:hidrometro_marca, :hidrometro_capacidade, :hidrometro_protecao,
        :cliente_retornos, :fonte_abastecimento, :ramal_local_instalacao,
        :imovel_tipo_ocupante_quantidade_retornos, :situacao_atualizacao_cadastral]

      irs = []
      if limit.present? and limit > 0
        irs = empresa.imovel_retornos.includes(inclusoes).limit(limit)
      else
        irs = empresa.imovel_retornos.includes(inclusoes)
      end

      dados = irs.map do |ir|
        imovel = Recadastramento::Arquivo::Imovel.new(ir)
        hidrometro = Recadastramento::Arquivo::Hidrometro.new(ir.hidrometro_marca, ir.hidrometro_capacidade, ir.hidrometro_protecao)
        cliente_usuario = Recadastramento::Arquivo::Clientes::ClienteUsuario.new(ir.cliente_usuario_retorno)
        cliente_proprietario = Recadastramento::Arquivo::Clientes::ClienteProprietario.new(ir.cliente_proprietario_retorno)
        cliente_responsavel = Recadastramento::Arquivo::Clientes::ClienteResponsavel.new(ir.cliente_responsavel_retorno)
        Recadastramento::Dado.new(imovel, cliente_usuario, cliente_responsavel, cliente_proprietario, hidrometro)
      end

      Recadastramento::GeradorCSV.new(dados, "imovel_retorno_31082016-2").gerar
    end
  end
end