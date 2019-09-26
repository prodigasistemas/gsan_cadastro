class Atendimento::Parcelamento < Imovel
  def parcelamentos_efetuados
    cadastro = {}

    cadastro[:efetuados] = get_efetuados

    cadastro
  end

  private

  def get_efetuados
    parcelamento_efetuados = []

    parcelas.map do |parcela|
      q = {}
      q[:data_hora] = parcela.data_hora_parcelamento
      q[:debito_atualizado] = parcela.valor_debito_atualizado
      q[:desconto_concedido] = parcela.valor_desconto_acrescimos
      q[:entrada] = parcela.valor_entrada
      q[:numero_prestacoes] = parcela.numero_prestacoes
      q[:valor_prestacao] = parcela.valor_prestacoes
      q[:situacao] = parcela.situacao_parcelamento
      if parcela.situacao_parcelamento.present?
        q[:situacao] = parcela.situacao_parcelamento.descricao
      end
      parcelamento_efetuados << q
    end

    parcelamento_efetuados
  end
end
