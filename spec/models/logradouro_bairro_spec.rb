require "rails_helper"

describe LogradouroBairro do
  context "valida" do
    context "antes de destruir" do
      it "presenca de imovel" do
        logradouro_bairro = create :logradouro_bairro
        imovel = create :imovel, logradouro_bairro: logradouro_bairro

        logradouro_bairro.destroy
        expect(logradouro_bairro).to be_persisted
        expect(logradouro_bairro.errors).to include :imoveis
      end

      it "presenca de cliente endereco" do
        logradouro_bairro = create :logradouro_bairro
        endereco = create :cliente_endereco, logradouro_bairro: logradouro_bairro

        logradouro_bairro.destroy
        expect(logradouro_bairro).to be_persisted
        expect(logradouro_bairro.errors).to include :cliente_enderecos
      end
    end
  end
end
