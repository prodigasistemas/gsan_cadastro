class PopulaPerformance
  attr_accessor :referencia, :contrato

  def initialize(contrato_id, referencia)
    @contrato = ContratoMedicao.find contrato_id
    @referencia  = referencia
  end

  def setup
    @imoveis = contrato.imoveis
  end

  def atualiza_abrangencias
    abrangencias = contrato.abrangencias

    abrangencias.each do |abrangencia| 
      conta = buscar_conta(abrangencia.imovel_id, contrato.referencia_assinatura)
      if conta.present?
       abrangencia.ligacao_agua_situacao_id = conta.ligacao_agua_situacao_id
      else
       abrangencia.ligacao_agua_situacao_id = LigacaoAguaSituacao::SITUACAO[:factivel]
      end
      abrangencia.save!
    end
  end

  def cadastra_performance
    setup

    return if @referencia <= @contrato.referencia_assinatura

    MedicaoPerformance.where(ano_mes_referencia: @referencia).destroy_all

    @imoveis.each do |imovel|
      conta_referencia = buscar_conta(imovel.id, @referencia)

      next if not conta_referencia.present?

      conta_mes_zero   = buscar_conta(imovel.id, @contrato.referencia_assinatura)

      percentual = 0

      @contrato.coeficientes.each do |coeficiente|
        if coeficiente.ligacao_agua_id == imovel.situacao_ligacao_agua_id
          percentual = coeficiente.coeficiente
        end
      end

      diferenca = valor_agua(conta_referencia) - valor_agua(conta_mes_zero)

      diferenca = diferenca > 0 ? diferenca : 0

      calculo = diferenca * percentual / 100
    
      medicao = MedicaoPerformance.new
      medicao.ano_mes_referencia           = @referencia
      medicao.contrato_medicao             = @contrato
      medicao.valor_diferenca_agua         = diferenca
      medicao.calculo                      = calculo
      medicao.imovel                       = imovel
      medicao.debito_credito_situacao_id   = situacao_conta(conta_referencia)
      medicao.valor_agua_faturado          = valor_agua(conta_referencia)
      medicao.valor_agua_faturado_mes_zero = valor_agua(conta_mes_zero)
      medicao.consumo_referencia           = consumo_agua(conta_referencia)
      medicao.consumo_mes_zero             = consumo_agua(conta_mes_zero)
      medicao.save!      
    end
  end

  def buscar_conta(imovel_id, referencia)
    situacoes_cancelada = [
      DebitoCreditoSituacao::SITUACAO[:cancelada],
      DebitoCreditoSituacao::SITUACAO[:cancelada_por_retificacao]
    ]

    conta = Conta.where(imovel_id: imovel_id).
      where(ano_mes_referencia: referencia).
      where("dcst_idatual = ? or dcst_idanterior = ?", DebitoCreditoSituacao::SITUACAO[:normal], DebitoCreditoSituacao::SITUACAO[:normal]).
      where("cnta_amreferenciaconta >= ? and cnta_amreferenciaconta <= ?", @contrato.ano_mes_vigencia_inicial, @contrato.ano_mes_vigencia_final)

    if not conta.present?
      conta = Conta.where(imovel_id: imovel_id).
        where(ano_mes_referencia: referencia).
        where(debito_credito_situacao_id_atual:  DebitoCreditoSituacao::SITUACAO[:incluida]).
        where("cnta_amreferenciaconta >= ? and cnta_amreferenciaconta <= ?", @contrato.ano_mes_vigencia_inicial, @contrato.ano_mes_vigencia_final)
    end

    if not conta.present?
      conta = Conta.where(imovel_id: imovel_id).
        where(ano_mes_referencia_contabil: referencia).
        where(debito_credito_situacao_id_atual:  DebitoCreditoSituacao::SITUACAO[:retificada]).
        where("cnta_amreferenciacontabil >= ? and cnta_amreferenciacontabil <= ?", @contrato.ano_mes_vigencia_inicial, @contrato.ano_mes_vigencia_final)
    end

    if not conta.present?
      conta = ContaHistorico.where(imovel_id: imovel_id, ano_mes_referencia_contabil: referencia, debito_credito_situacao_id_atual: situacoes_cancelada).
        where("cnhi_amreferenciacontabil >= ? and cnhi_amreferenciacontabil <= ?", @contrato.ano_mes_vigencia_inicial, @contrato.ano_mes_vigencia_final)
    end

    return conta.present? ? conta.first : nil
  end

  def valor_agua(conta)
    return conta.present? ? conta.valor_agua : 0
  end

  def consumo_agua(conta)
    return conta.present? ? conta.consumo_agua : 0
  end

  def situacao_conta(conta)
    return conta.present? ? conta.debito_credito_situacao_id_atual : 0
  end
end