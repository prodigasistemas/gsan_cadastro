class PopulaPerformance
  attr_accessor :referencia, :contrato

  def initialize(contrato_id, referencia)
    @contrato = ContratoMedicao.find contrato_id
    @referencia  = referencia
  end

  def setup
    @imoveis = contrato.imoveis
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
      medicao.ano_mes_referencia             = @referencia
      medicao.contrato_medicao               = @contrato
      medicao.valor_diferenca_consumo_agua   = diferenca
      medicao.calculo                        = calculo
      medicao.imovel                         = imovel
      medicao.debito_credito_situacao_id     = situacao_conta(conta_referencia)
      medicao.valor_diferenca_consumo_esgoto = valor_agua(conta_referencia)
      medicao.save!      
    end
  end

  def buscar_conta(imovel_id, referencia)
    situacoes = [DebitoCreditoSituacao::SITUACAO[:normal], DebitoCreditoSituacao::SITUACAO[:retificada], DebitoCreditoSituacao::SITUACAO[:incluida]]

    conta = Conta.find_by(imovel_id: imovel_id, mes_ano_referencia: referencia, debito_credito_situacao_id_atual: situacoes)

    if conta.nil?
      conta = ContaHistorico.find_by(imovel_id: imovel_id, mes_ano_referencia: referencia, debito_credito_situacao_id_atual: situacoes)
    end

    return conta
  end

  def valor_agua(conta)
    return conta.present? ? conta.valor_agua : 0
  end

  def situacao_conta(conta)
    return conta.present? ? conta.debito_credito_situacao_id_atual : 0
  end
end