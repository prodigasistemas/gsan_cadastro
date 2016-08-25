class ArquivoRecadastramentoJob
  include SuckerPunch::Job

  def perform(usuario, nome_arquivo)
    dados = []

    usuario.empresas.each do |empresa|
      empresa.imovel_retornos.each do |ir|
        imovel = Recadastramento::Arquivo::Imovel.new ir
        hidrometro = Recadastramento::Arquivo::Hidrometro.new ir.hidrometro_marca, ir.hidrometro_capacidade, ir.hidrometro_protecao
        cliente = Recadastramento::Arquivo::Cliente.new ir.cliente_usuario_retorno
        dados << Recadastramento::Dado.new(imovel, cliente, hidrometro)
      end
    end

    arquivo = Recadastramento::GeradorCSV.new(dados, nome_arquivo).gerar
  end
end
