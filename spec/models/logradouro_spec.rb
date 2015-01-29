require "rails_helper"

describe Logradouro do
  it { should validate_presence_of :nome }
  it { should validate_presence_of :logradouro_tipo_id }
  it { should validate_presence_of :municipio_id }
  it { should ensure_length_of(:nome).is_at_most(40) }
  it { should ensure_length_of(:nome_popular).is_at_most(30) }

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end

  context "antes de deletar logradouro ceps" do
    let!(:logradouro)       { create :logradouro }
    let!(:cep)              { create :cep }
    let!(:logradouro_cep)   { create :logradouro_cep,   logradouro: logradouro,         cep: cep }
    let!(:imovel)           { create :imovel,           logradouro_cep: logradouro_cep }
    let!(:cliente_endereco) { create :cliente_endereco, logradouro_cep: logradouro_cep }

    it "valida se logradouro cep possui relacionamento com imoveis" do
      logradouro.reload.logradouro_ceps_attributes = [{id: logradouro_cep.id, _destroy: 1}]

      expect(logradouro).to_not be_valid
      expect(logradouro.errors[:base]).to include "Imóveis ainda existem no CEP #{cep.codigo}"
    end

    it "valida se logradouro cep possui relacionamento com cliente endereco" do
      logradouro.reload.logradouro_ceps_attributes = [{id: logradouro_cep.id, _destroy: 1}]

      expect(logradouro).to_not be_valid
      expect(logradouro.errors[:base]).to include "Endereço de cliente ainda existem no CEP #{cep.codigo}"
    end
  end

  context "antes de deletar logradouro bairros" do
    let!(:logradouro)        { create :logradouro }
    let!(:bairro)            { create :bairro, nome: "VICENTE DE MAUA" }
    let!(:logradouro_bairro) { create :logradouro_bairro, logradouro: logradouro, bairro: bairro }
    let!(:imovel)            { create :imovel,            logradouro_bairro: logradouro_bairro }
    let!(:cliente_endereco)  { create :cliente_endereco,  logradouro_bairro: logradouro_bairro }

    it "valida se logradouro cep possui relacionamento com imoveis" do
      logradouro.reload.logradouro_bairros_attributes = [{id: logradouro_bairro.id, _destroy: 1}]

      expect(logradouro).to_not be_valid
      expect(logradouro.errors[:base]).to include "Imóveis ainda existem no bairro VICENTE DE MAUA"
    end

    it "valida se logradouro cep possui relacionamento com imoveis" do
      logradouro.reload.logradouro_bairros_attributes = [{id: logradouro_bairro.id, _destroy: 1}]

      expect(logradouro).to_not be_valid
      expect(logradouro.errors[:base]).to include "Endereço de cliente ainda existem no bairro VICENTE DE MAUA"
    end
  end
end
