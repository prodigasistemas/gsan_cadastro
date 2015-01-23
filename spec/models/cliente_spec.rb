require "rails_helper"

describe Cliente do
  describe "validacoes" do
    
    it { should validate_presence_of   :nome }

    context "quando o cliente é pessoa física" do
      let(:pessoa_fisica) { create(:cliente_tipo, :pessoa_fisica) }
      let(:cliente) { create(:cliente, :pessoa_fisica, cliente_tipo: pessoa_fisica) }
      subject(:novo_cliente) { build(:cliente, :pessoa_fisica, cliente_tipo: pessoa_fisica) }

      it "cpf deve ser único" do
        expect(novo_cliente).to be_valid
        novo_cliente.cpf = cliente.cpf
        expect(novo_cliente).to be_invalid
      end

      it "cpf deve ser obrigatório" do
        expect(novo_cliente).to be_valid
        novo_cliente.cpf =  ''
        expect(novo_cliente).to be_invalid
      end

      describe "cpf" do
        it { should allow_value("12345678911").for :cpf }
        it { should_not allow_value("123456789111").for :cpf }
        it { should_not allow_value("1234567891").for :cpf }
        it { should_not allow_value("1234567891d").for :cpf }
      end
    end

    context "quando o cliente é pessoa jurídica" do
      let(:pessoa_juridica) { create(:cliente_tipo, :pessoa_juridica) }
      let(:cliente) { create(:cliente, :pessoa_juridica, cliente_tipo: pessoa_juridica) }
      subject(:novo_cliente) { build(:cliente, :pessoa_juridica, cliente_tipo: pessoa_juridica) }

      it "cnpj deve ser único" do
        expect(novo_cliente).to be_valid
        novo_cliente.cnpj = cliente.cnpj
        expect(novo_cliente).to be_invalid
      end

      it "cnpj deve ser obrigatório" do
        expect(novo_cliente).to be_valid
        novo_cliente.cnpj =  ''
        expect(novo_cliente).to be_invalid
      end
    end
    
    it_behaves_like 'ativo'

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
end
