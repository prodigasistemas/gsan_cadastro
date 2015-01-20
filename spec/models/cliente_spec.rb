require "rails_helper"

describe Cliente do
  it { should validate_presence_of :nome }

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end
  describe "acao_cobranca" do
    it { should     allow_value(nil).for :acao_cobranca }
    it { should     allow_value(1).for :acao_cobranca }
    it { should     allow_value(2).for :acao_cobranca }
    it { should_not allow_value(0).for :acao_cobranca }
    it { should_not allow_value(3).for :acao_cobranca }
  end
  describe "cobranca_acrescimos" do
    it { should     allow_value(nil).for :cobranca_acrescimos }
    it { should     allow_value(1).for :cobranca_acrescimos }
    it { should     allow_value(2).for :cobranca_acrescimos }
    it { should_not allow_value(0).for :cobranca_acrescimos }
    it { should_not allow_value(3).for :cobranca_acrescimos }
  end
  describe "arquivo_texto" do
    it { should     allow_value(nil).for :arquivo_texto }
    it { should     allow_value(1).for :arquivo_texto }
    it { should     allow_value(2).for :arquivo_texto }
    it { should_not allow_value(0).for :arquivo_texto }
    it { should_not allow_value(3).for :arquivo_texto }
  end
  describe "vencimento_mes_seguinte" do
    it { should     allow_value(nil).for :vencimento_mes_seguinte }
    it { should     allow_value(1).for :vencimento_mes_seguinte }
    it { should     allow_value(2).for :vencimento_mes_seguinte }
    it { should_not allow_value(0).for :vencimento_mes_seguinte }
    it { should_not allow_value(3).for :vencimento_mes_seguinte }
  end
  describe "gera_fatura_antecipada" do
    it { should     allow_value(nil).for :gera_fatura_antecipada }
    it { should     allow_value(1).for :gera_fatura_antecipada }
    it { should     allow_value(2).for :gera_fatura_antecipada }
    it { should_not allow_value(0).for :gera_fatura_antecipada }
    it { should_not allow_value(3).for :gera_fatura_antecipada }
  end
  describe "nome_fantasia_conta" do
    it { should     allow_value(1).for :nome_fantasia_conta }
    it { should     allow_value(2).for :nome_fantasia_conta }
    it { should_not allow_value(0).for :nome_fantasia_conta }
    it { should_not allow_value(3).for :nome_fantasia_conta }
  end
  describe "permite_negativacao" do
    it { should     allow_value(1).for :permite_negativacao }
    it { should     allow_value(2).for :permite_negativacao }
    it { should_not allow_value(0).for :permite_negativacao }
    it { should_not allow_value(3).for :permite_negativacao }
  end
  describe "negativacao_periodo" do
    it { should     allow_value(1).for :negativacao_periodo }
    it { should     allow_value(2).for :negativacao_periodo }
    it { should_not allow_value(0).for :negativacao_periodo }
    it { should_not allow_value(3).for :negativacao_periodo }
  end
end
