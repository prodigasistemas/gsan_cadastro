require "rails_helper"

describe LogradouroCep do
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
