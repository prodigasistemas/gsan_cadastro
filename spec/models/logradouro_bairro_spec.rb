require "rails_helper"

describe LogradouroBairro do
  context "valida" do
    context "ao destruir" do
      it "presenca de imovel" do
        logradouro_bairro = create :logradouro_bairro

        expect(logradouro_bairro.valid? :destroy).to be true
        imovel = create :imovel, logradouro_bairro: logradouro_bairro

        expect(logradouro_bairro.reload.valid? :destroy).to be false
      end
    end

    context "antes de destruir" do
      it "presenca de imovel" do
        logradouro_bairro = create :logradouro_bairro
        imovel = create :imovel, logradouro_bairro: logradouro_bairro

        logradouro_bairro.destroy
        expect(logradouro_bairro).to be_persisted
        expect(logradouro_bairro.errors).to include :imoveis
      end
    end
  end
end
