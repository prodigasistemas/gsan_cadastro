require 'rails_helper'

describe ClienteEndereco do
  let(:cliente_tipo) { create(:cliente_tipo, :pessoa_fisica) }
  let(:logradouro_cep) { create(:logradouro_cep) }
  let(:logradouro_bairro) { create(:logradouro_bairro) }
  let(:cliente) { create(:cliente, :pessoa_fisica, cliente_tipo: cliente_tipo) }
  subject!(:cliente_endereco) {
    create(:cliente_endereco, cliente_id: cliente.id, logradouro_cep: logradouro_cep, logradouro_bairro: logradouro_bairro)
  }

  describe "validações" do
    it { should validate_presence_of :numero }
    it { should validate_presence_of :logradouro_bairro }
    it { should validate_presence_of :logradouro_cep }
    it { should validate_presence_of :referencia }
    it { should validate_presence_of :cliente }
    it { should validate_presence_of :endereco_tipo }
    it { should validate_presence_of :logradouro }
    it { should ensure_length_of(:numero).is_at_most(5) }
    it { should ensure_length_of(:complemento).is_at_most(25) }

    context "correspondencia" do
      let(:cliente)    { create :cliente }
      let!(:endereco_1) { create :cliente_endereco, cliente_id: cliente.id, correspondencia: 1 }
      let!(:endereco_2) { build  :cliente_endereco, cliente_id: cliente.id, correspondencia: 2 }

      it "somente um endereco pode ser marcado como correspondencia" do
        expect(endereco_2).to be_valid
        endereco_2.correspondencia = 1
        expect(endereco_2).to be_invalid
        expect(endereco_2.errors[:correspondencia]).to include "deve ser único"
      end
    end
  end

  describe "CEP id e bairro id" do
    context "quando logradouro_cep e logradouro_bairro existem" do
      it "deve setar cep_id pelo logradouro_cep" do
        expect(cliente_endereco.cep_id).to eq logradouro_cep.cep_id
      end

      it "deve setar bairro_id pelo logradouro_bairro" do
        expect(cliente_endereco.bairro_id).to eq logradouro_bairro.bairro_id
      end
    end

    # context "quando logradouro_cep e logradouro_bairro não existem" do
    #   let(:cliente_tipo) { create(:cliente_tipo, :pessoa_fisica) }
    #   let(:cliente) { create(:cliente, :pessoa_fisica, cliente_tipo: cliente_tipo) }
    #   subject(:cliente_endereco) {
    #     create(
    #       :cliente_endereco, 
    #       cliente_id: cliente.id,
    #       logradouro_cep: nil,
    #       logradouro_bairro: nil
    #     )
    #   }

    #   it "cep_id é nil" do
    #     expect(cliente_endereco.cep_id).to be_nil
    #   end

    #   it "bairro_id é nil" do
    #     expect(cliente_endereco.bairro_id).to be_nil
    #   end
    # end
  end
end
