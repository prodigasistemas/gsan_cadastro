require "rails_helper"

describe LogradouroCep do
  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end

  context "valida" do
    context "ao destruir" do
      it "presenca de imovel" do
        logradouro_cep = create :logradouro_cep

        expect(logradouro_cep.valid? :destroy).to be true
        imovel = create :imovel, logradouro_cep: logradouro_cep

        expect(logradouro_cep.reload.valid? :destroy).to be false
      end
    end

    context "antes de destruir" do
      it "presenca de imovel" do
        logradouro_cep = create :logradouro_cep
        imovel = create :imovel, logradouro_cep: logradouro_cep

        logradouro_cep.destroy
        expect(logradouro_cep).to be_persisted
        expect(logradouro_cep.errors).to include :imoveis
      end
    end
  end
end
