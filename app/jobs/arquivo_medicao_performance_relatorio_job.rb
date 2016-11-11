class ArquivoMedicaoPerformanceRelatorioJob
  include SuckerPunch::Job

  def perform(nome_arquivo, gerador, historico)
    gerador.gerar

    historico.situacao = 'concluido'
    historico.caminho_arquivo = nome_arquivo
    historico.save!
  end
end
