require "rails_helper"

describe Cliente do
  describe "validacoes" do
    it { should validate_presence_of :nome }
    it { should validate_presence_of :cliente_tipo }

    context "endereco de correspondencia" do
      let(:cliente)     { create :cliente }
      let!(:endereco_1) { create :cliente_endereco, cliente: cliente, correspondencia: 1 }
      let!(:endereco_2) { create :cliente_endereco, cliente: cliente, correspondencia: 2 }
      let!(:params)     { build(:cliente_endereco, correspondencia: 1, cliente: nil).attributes }

      it "somente um endereco pode ser marcado como correspondencia" do
        expect(cliente.reload).to be_valid
        params.delete "clie_id"
        cliente.enderecos_attributes = [params]
        expect(cliente).to be_invalid
        expect(cliente.errors[:base]).to include "Somente um endereço pode ser marcado como de correspondência"
      end

      context "ao editar endereco" do
        it "ao menos um dos enderecos devem ser de correspondencia" do
          expect(cliente.reload).to be_valid
          cliente.enderecos_attributes = { id: endereco_1.id, correspondencia: 2 }
          expect(cliente).to be_invalid
          expect(cliente.errors[:base]).to include "Ao menos um dos endereços deve ser de correspondência"
        end
      end

      context "ao deletar endereco de correspondencia" do
        context "deletando todos os enderecos" do
          it "ainda e valido" do
            expect(cliente.reload).to be_valid
            cliente.enderecos_attributes = [{ id: endereco_1.id, _destroy: 1 },{ id: endereco_2.id, _destroy: 1}]
            expect(cliente).to be_valid
          end
        end

        context "quando ainda existir um endereco" do
          it "ao menos um dos enderecos devem ser de correspondencia" do
            expect(cliente.reload).to be_valid
            cliente.enderecos_attributes = { id: endereco_1.id, _destroy: 1 }

            expect(cliente).to be_invalid
            expect(cliente.errors[:base]).to include "Ao menos um dos endereços deve ser de correspondência"
          end
        end
      end
    end

    context "telefone padrao" do
      let(:cliente) { create :cliente }
      let!(:fone_1) { create :cliente_fone, cliente: cliente, padrao: 1 }
      let!(:fone_2) { create :cliente_fone, cliente: cliente, padrao: 2 }
      let!(:params) { build(:cliente_fone, padrao: 1, cliente: nil).attributes }

      it "somente um telefone pode ser marcado como padrao" do
        expect(cliente.reload).to be_valid
        params.delete "clie_id"
        cliente.telefones_attributes = [params]
        expect(cliente).to be_invalid
        expect(cliente.errors[:base]).to include "Somente um telefone pode ser marcado como padrão"
      end

      context "ao editar telefone" do
        it "ao menos um dos telefones devem ser padrao" do
          expect(cliente.reload).to be_valid
          cliente.telefones_attributes = { id: fone_1.id, padrao: 2 }
          expect(cliente).to be_invalid
          expect(cliente.errors[:base]).to include "Ao menos um dos telefones deve ser padrao"
        end
      end

      context "ao deletar telefone padrao" do
        context "deletando todos os telefones" do
          it "ainda e valido" do
            expect(cliente.reload).to be_valid
            cliente.telefones_attributes = [{ id: fone_1.id, _destroy: 1 },{ id: fone_2.id, _destroy: 1}]
            expect(cliente).to be_valid
          end
        end

        context "quando ainda existir um telefone" do
          it "ao menos um dos telefones deve ser padrao" do
            expect(cliente.reload).to be_valid
            cliente.telefones_attributes = { id: fone_1.id, _destroy: 1 }

            expect(cliente).to be_invalid
            expect(cliente.errors[:base]).to include "Ao menos um dos telefones deve ser padrao"
          end
        end
      end
    end

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

      describe "cnpj" do
        it { should allow_value("12345678909876").for :cnpj }
        it { should_not allow_value("123456789098760").for :cnpj }
        it { should_not allow_value("1234567890987").for :cnpj }
        it { should_not allow_value("1234567890987a").for :cnpj }
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

  describe "ao salvar cliente" do
    context "quando cliente e pessoa fisica" do
      let(:cliente) { create(:cliente, :pessoa_fisica) }

      it "apaga referencias de pessoa juridica" do
        cliente.cnpj = 12345678909876
        cliente.ramo_atividade_id = 1
        cliente.cliente_responsavel_superior_id = 1

        cliente.save!

        expect(cliente.cnpj).to be_nil
        expect(cliente.ramo_atividade_id).to be_nil
        expect(cliente.cliente_responsavel_superior_id).to be_nil
      end
    end
    context "quando cliente e pessoa juridica" do
      let(:cliente) { create(:cliente, :pessoa_juridica) }

      it "apaga referencias de pessoa fisica" do
        cliente.cpf =                 94299888267
        cliente.rg =                  94299888267
        cliente.orgao_emissor_rg_id = 1
        cliente.orgao_emissor_uf_id = 2
        cliente.profissao_id        = 3
        cliente.pessoa_sexo_id      = 1
        cliente.data_emissao_rg     = Date.today
        cliente.nascimento          = Date.today
        cliente.nome_mae            = "Maria"

        cliente.save!

        expect(cliente.cpf                ).to be_nil
        expect(cliente.rg                 ).to be_nil
        expect(cliente.orgao_emissor_rg_id).to be_nil
        expect(cliente.orgao_emissor_uf_id).to be_nil
        expect(cliente.profissao_id       ).to be_nil
        expect(cliente.pessoa_sexo_id     ).to be_nil
        expect(cliente.data_emissao_rg    ).to be_nil
        expect(cliente.nascimento         ).to be_nil
        expect(cliente.nome_mae           ).to be_nil
      end
    end
  end
end
