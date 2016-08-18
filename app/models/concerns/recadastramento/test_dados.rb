module Recadastramento
  class TestDados

    def gerar_para(empresa, limit = 10)
      return unless empresa

      inclusoes = [:hidrometro_marca, :hidrometro_capacidade, :hidrometro_protecao,
        :cliente_retornos, :fonte_abastecimento, :ramal_local_instalacao,
        :imovel_tipo_ocupante_quantidade_retornos, :situacao_atualizacao_cadastral]

      irs = nil
      irs = empresa.imovel_retornos.includes(inclusoes).limit(limit) if limit.present? and limit > 0
      irs ||= empresa.imovel_retornos.includes(inclusoes)

      dados = irs.map do |ir|
        imovel = Recadastramento::Arquivo::Imovel.new(ir)
        hidrometro = Recadastramento::Arquivo::Hidrometro.new(ir.hidrometro_marca, ir.hidrometro_capacidade, ir.hidrometro_protecao)
        cliente = Recadastramento::Arquivo::Cliente.new(ir.cliente_usuario_retorno)
        Recadastramento::Dado.new(imovel, cliente, hidrometro)
      end

      Recadastramento::GeradorCSV.new(dados).gerar
    end
  end
end