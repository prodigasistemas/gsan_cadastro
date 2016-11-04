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

    @imoveis.each do |imovel|
      conta_mes_zero   = buscar_conta(imovel.id, @contrato.referencia_assinatura)
      conta_referencia = buscar_conta(imovel.id, @referencia)

      percentual = 0

      @contrato.coeficientes.each do |coeficiente|
        if coeficiente.ligacao_agua_id == imovel.situacao_ligacao_agua_id
          percentual = coeficiente.coeficiente
        end
      end

      calculo = (conta_referencia - conta_mes_zero) * percentual / 100

      calculo = calculo > 0 ? calculo : 0;
    
      medicao = MedicaoPerformance.new
      medicao.ano_mes_referencia           = @referencia
      medicao.contrato_medicao             = @contrato
      medicao.calculo                      = calculo
      medicao.imovel                       = imovel
      medicao.save!      
    end
  end

  def buscar_conta(imovel_id, referencia)
    situacoes = [DebitoCreditoSituacao::SITUACAO[:normal], DebitoCreditoSituacao::SITUACAO[:retificada], DebitoCreditoSituacao::SITUACAO[:incluida]]

    conta = Conta.find_by(imovel_id: imovel_id, mes_ano_referencia: referencia, debito_credito_situacao_id_atual: situacoes)

    if conta.nil?
      conta = ContaHistorico.find_by(imovel_id: imovel_id, mes_ano_referencia: referencia, debito_credito_situacao_id_atual: situacoes)
    end

    return conta.present? ? conta.valor_agua : 0
  end

end