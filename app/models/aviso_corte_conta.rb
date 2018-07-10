class AvisoCorteConta
  attr_accessor :referencia, :vencimento, :valor

  def initialize(conta)
    @referencia = conta[:referencia]
    @vencimento = conta[:vencimento]
    @valor = conta[:valor]
  end
end