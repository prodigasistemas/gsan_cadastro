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
      conta_mes_zero   = buscar_conta(imovel.id, @contrato.referencia_assinatura)
      conta_referencia = buscar_conta(imovel.id, @referencia)

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
    conta = Conta.find_by(imovel_id: imovel_id, mes_ano_referencia: referencia)

    if conta.nil?
      conta = ContaHistorico.find_by(imovel_id: imovel_id, mes_ano_referencia: referencia)
    end

    return conta
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