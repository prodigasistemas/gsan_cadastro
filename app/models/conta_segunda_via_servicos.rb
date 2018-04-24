class ContaSegundaViaServicos
  attr_accessor :descricao, :faixa, :valor

  def initialize(servico)
    @descricao = servico[:descricaoServicosTarifas]
    @faixa = servico[:consumoFaixa]
    @valor = servico[:valor]
  end
end