class ArquivoHidrometroInstalacaoHistoricoJob
  include SuckerPunch::Job

  def perform(hidrometro_historicos, nome_arquivo, historico)
    dados = hidrometro_historicos.map{ |hh| Recadastramento::DadoHidrometroInstalacaoHistorico.new(hh) }

    Recadastramento::GeradorCSV.new(dados, nome_arquivo).gerar

    historico.situacao = 'concluido'
    historico.caminho_arquivo = nome_arquivo
    historico.save!
  end
end
