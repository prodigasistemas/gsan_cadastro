class Atendimento::Parcelamento < Imovel
  def parcelamentos_efetuados
    cadastro = {}

    cadastro[:efetuados] = get_efetuados

    cadastro
  end

  private

  def get_efetuados
    efetuados = []

    q = {}
    parcelas.map do |p|
      q[:data_hora] = p.data_hora_parcelamento
      q[:debito_atualizado] = p.valor_debito_atualizado
      q[:desconto_concedido] = p.valor_desconto_acrescimos
      q[:entrada] = p.valor_entrada
      q[:numero_prestacoes] = p.numero_prestacoes
      q[:valor_prestacao] = p.valor_prestacoes
      if p.situacao_parcelamento.present?
        q[:situacao] = p.situacao_parcelamento.descricao
      end
      efetuados << q
    end

    efetuados
  end
end
