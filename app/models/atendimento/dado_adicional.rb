class Atendimento::DadoAdicional < Imovel
  
    def dados_adicionais
      cadastro = {}

      cadastro[:consumo_tarifa] = get_consumo_tarifa
      cadastro[:funcionario] = get_funcionario
      cadastro[:vencimentos_alternativos] = get_vencimentos_alternativos
      cadastro[:debitos_automaticos] = get_debitos_automaticos
      cadastro[:faturamento_situacao_historico] = get_faturamento_situacao_historico
      cadastro[:imovel_cobrancas_situacoes] = get_imovel_cobrancas_situacoes
      cadastro[:cobrancas_situacoes_especiais] = get_cobrancas_situacoes_especiais
      cadastro[:imovel_elos_anormalidades] = get_imovel_elos_anormalidades
      cadastro[:imovel_cadastros_ocorrencias] = get_imovel_cadastros_ocorrencias
      cadastro[:imovel_ramos_atividades] = get_imovel_ramos_atividades
  
      cadastro
    end    

  private 

  def get_cliente_usuario
    cliente_imovel = self.cliente_imoveis.where(tipo_relacao: 2, data_fim_relacao: nil).first

    return if cliente_imovel.nil?
    return if cliente_imovel.cliente.nil?

    cliente_imovel.cliente.id.to_s << " - " << cliente_imovel.cliente.nome
  end

  def get_numero_hidrometro
    hidrometro = self.hidrometro_instalacao_agua_historicos.first

    return if hidrometro.nil?

    hidrometro.numero_hidrometro
  end

  def get_vencimentos_alternativos
    vencimentos = []

    vencimentos_alternativos.map do |vencimento|
      v = {}
      v[:id] = vencimento.id
      v[:data_implantacao] = vencimento.data_implantacao
      v[:data_vencimento] = vencimento.data_vencimento
      v[:data_exclusao] = vencimento.data_exclusao

      vencimentos << v
    end

    vencimentos
  end

  def get_debitos_automaticos
    debitos = []

    debitos_automaticos.map do |debito|
      t = {}
      t[:id] = debito.id
      t[:descricao_banco]                       = debito.agencia.banco.descricaoAbreviada
      t[:codigo_agencia]                        = debito.agencia.codigo
      t[:identificacao_cliente_banco]           = debito.identificacaoClienteBanco
      t[:data_opcao_debito_conta_corrente]      = debito.dataOpcaoDebitoContaCorrente
      t[:data_inclusao_novo_debito_automatico]  = debito.dataInclusaoNovoDebitoAutomatico
      t[:data_exclusao]                         = debito.dataExclusao

      debitos << t
    end

    debitos
  end

  def get_faturamento_situacao_historico
    historicos = []

    faturamento_situacao_historico.map do |historico|
      t = {}

      t[:tipo]          = historico.faturamento_situacao_tipo.descricao 
      t[:motivo]        = historico.faturamento_situacao_motivo.descricao
      t[:data_inicio]   = historico.anoMesFaturamentoSituacaoInicio
      t[:data_fim]      = historico.anoMesFaturamentoSituacaoFim
      t[:data_retirada] = historico.anoMesFaturamentoRetirada
      t[:data_inclusao] = historico.dataInclusao

      usuario = ""
      if historico.usuario.present?
        usuario = historico.usuario.nome
      else
        if historico.faturamento_situacao_comando_retirada.present? and historico.faturamento_situacao_comando_retirada.usuario.present?
          usuario = historico.faturamento_situacao_comando_retirada.usuario.nome
        else 
          usuario = historico.faturamento_situacao_comando_informa.usuario.nome if historico.faturamento_situacao_comando_informa.present?
        end
      end

      t[:usuario] = usuario

      historicos << t
    end
    
    historicos
  end

  def get_imovel_cobrancas_situacoes
    cobrancas = []

    imovel_cobrancas_situacoes.map do |cobranca|
      c = {}
      c[:id] = cobranca.id
      c[:descricao] = cobranca.cobranca_situacao.descricao
      c[:referencia] = cobranca.ano_mes_referencia_final
      c[:data_implantacao] = cobranca.data_implantacao
      c[:data_retirada] = cobranca.data_retirada
      c[:cliente_ativo] = cobranca.cliente
      if cobranca.escritorio.present?
        c[:escritorio_cobranca] = cobranca.escritorio.nome
      end

      if cobranca.advogado.present?
        c[:advogado_cobranca] = cobranca.advogado.nome
      end

      cobrancas << c
    end

    cobrancas
  end

  def get_cobrancas_situacoes_especiais
    cobrancas = []

    cobrancas_situacoes_especiais.map do |cobranca|
      c = {}
      c[:id] = cobranca.id
      if cobranca.cobranca_situacao_tipo.present?
        c[:tipo] = cobranca.cobranca_situacao_tipo.descricao
      end
      if cobranca.cobranca_situacao_motivo.present?
        c[:motivo] = cobranca.cobranca_situacao_motivo.descricao
      end
      c[:mes_ano_inicio] = cobranca.ano_mes_situacao_cobranca_inicio
      c[:mes_ano_fim] = cobranca.ano_mes_situacao_cobranca_final
      c[:mes_ano_retirada] = cobranca.ano_mes_cobranca_retirada
      if cobranca.usuario_informante.present?
        c[:usuario] = cobranca.usuario_informante.nome
      end
      cobrancas << c
    end

    cobrancas
  end

  def get_imovel_elos_anormalidades
    anormalidades = []

    imovel_elos_anormalidades.map do |anormalidade|
      a = {}
      a[:id] = anormalidade.id
      if anormalidade.elo_anormalidade.present?
        a[:descricao] = anormalidade.elo_anormalidade.descricao
      end
      a[:data_anormalidade] = anormalidade.data_anormalidade
      a[:foto_anormalidade] = anormalidade.foto_anormalidade
      anormalidades << a
    end

    anormalidades
  end

  def get_imovel_cadastros_ocorrencias
    ocorrencias = []

    imovel_cadastros_ocorrencias.map do |ocorrencia|
      c = {}
      c[:id] = ocorrencia.id
      if ocorrencia.cadastro_ocorrencia.present?
        c[:descricao] = ocorrencia.cadastro_ocorrencia.descricao
      end
      c[:data_ocorrencia] = ocorrencia.data_ocorrencia
      c[:foto_ocorrencia] = ocorrencia.foto_ocorrencia

      ocorrencias << c
    end

    ocorrencias
  end
  
  def get_imovel_ramos_atividades
    ramos = []

    imovel_ramos_atividades.map do |ramo|
      c = {}

      if ramo.ramo_atividade.present?
        c[:descricao] = ramo.ramo_atividade.descricao
      end
      if ramo.ramo_atividade.present?
        c[:codigo] = ramo.ramo_atividade.codigo
      end
      ramos << c
    end

    ramos
  end

  def get_consumo_tarifa
    return "" if consumo_tarifa.nil?

    consumo_tarifa.descricao
  end

  def get_funcionario
    return "" if funcionario.nil?

    f = "(" << funcionario.id << ") " << funcionario.nome ||= ""

    f
  end
end