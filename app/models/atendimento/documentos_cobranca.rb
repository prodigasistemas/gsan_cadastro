class Atendimento::DocumentosCobranca < Imovel
  def documentos_cobrancas
    cadastro = {}
        
    cobrancas = []

    cobrancas_documentos.map do |cobranca|
      t = {}
      t[:documento] = cobranca.id
      t[:acao_cobranca] = ''

      case cobranca.documento_emissao_forma.id
        when DocumentoEmissaoForma::TYPES[:CRONOGRAMA]
          cronograma = cobranca.cobranca_acao_atividade_cronograma
          t[:acao_cobranca] = cronograma.cobranca_acao_cronograma.cobranca_acao.descricao if cronograma.present?
        when DocumentoEmissaoForma::TYPES[:EVENTUAL]
          comando = cobranca.cobranca_acao_atividade_comando
          t[:acao_cobranca] = comando.cobranca_acao.descricao if comando.present?
      end
      
      t[:emissao] = cobranca.emissao
      t[:forma_emissao] = cobranca.documento_emissao_forma.descricao
      t[:tipo_documento] = cobranca.documento_tipo.descricao
      t[:valor_documento] = cobranca.valor_documento
      t[:qtdade_itens] = cobranca.cobranca_documento_itens.count

      ordens_servico = cobranca.ordens_servico
      t[:situacao_os] = 'Sem OS'
      if ordens_servico.present? and ordens_servico.length > 0
        os = ordens_servico[0]
        t[:id_ordem_servico] = os.id
        t[:situacao_os] = OrdemServico::NOMES_SITUACAO[os.situacao] 
      end

      cobrancas << t
    end
        
    cadastro[:cobrancas] = cobrancas

    cadastro
  end
end
  