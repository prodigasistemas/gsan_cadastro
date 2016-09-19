class ArquivoRecadastramentoJob
  include SuckerPunch::Job

  def perform(irs, nome_arquivo)
    dados = irs.map{ |ir| Recadastramento::DadoImovelRetorno.new(ir) }

    Recadastramento::GeradorCSV.new(dados, nome_arquivo).gerar
  end
end
