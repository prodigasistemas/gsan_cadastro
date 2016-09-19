class ArquivoRecadastramentoJob
  include SuckerPunch::Job

  def perform(irs, nome_arquivo, historico)
    dados = irs.map{ |ir| Recadastramento::DadoImovelRetorno.new(ir) }

    Recadastramento::GeradorCSV.new(dados, nome_arquivo).gerar

    historico.situacao = 'concluido'
    historico.caminho_arquivo = nome_arquivo
    historico.save!
  end
end
