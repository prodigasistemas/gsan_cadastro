class ArquivoRecadastramentoJob
  include SuckerPunch::Job

  def perform(usuario, nome_arquivo)
    dados = []

    usuario.empresas.each do |empresa|
      empresa.imovel_retornos.each do |ir|
        dados << Recadastramento::Dado.new(ir)
      end
    end

    arquivo = Recadastramento::GeradorCSV.new(dados, nome_arquivo).gerar
  end
end
