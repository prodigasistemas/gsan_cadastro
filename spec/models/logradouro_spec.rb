require "rails_helper"

describe Logradouro do
  it { should validate_presence_of :nome }
  it { should validate_presence_of :logradouro_tipo_id }
  it { should validate_presence_of :municipio_id }

  context "antes de deletar logradouro ceps" do
    let!(:logradouro)     { create :logradouro }
    let!(:logradouro_cep) { create :logradouro_cep, logradouro: logradouro }
    let!(:imovel)         { create :imovel, logradouro_cep: logradouro_cep }

    it "valida se logradouro cep possui relacionamento com imoveis" do
      logradouro.reload.logradouro_ceps_attributes = [{id: logradouro_cep.id, _destroy: 1}]

      expect(logradouro).to_not be_valid
      expect(logradouro.errors[:base]).to include "Imóveis ainda existem no CEP 66093050"
    end
  end

  context "antes de deletar logradouro bairros" do
    let!(:logradouro)        { create :logradouro }
    let!(:logradouro_bairro) { create :logradouro_bairro, logradouro: logradouro }
    let!(:imovel)            { create :imovel, logradouro_bairro: logradouro_bairro }

    it "valida se logradouro cep possui relacionamento com imoveis" do
      logradouro.reload.logradouro_bairros_attributes = [{id: logradouro_bairro.id, _destroy: 1}]

      expect(logradouro).to_not be_valid
      expect(logradouro.errors[:base]).to include "Imóveis ainda existem no bairro ALGODOAL"
    end
  end
end
