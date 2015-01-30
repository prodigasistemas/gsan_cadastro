require "rails_helper"

describe EnderecoTipo do
  it { should validate_presence_of    :descricao }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    tipo = create :endereco_tipo
    novo_tipo = build :endereco_tipo
    expect(novo_tipo).to be_valid
    novo_tipo.descricao = tipo.descricao
    expect(novo_tipo).to be_invalid
  end

  it "tamanho da descricao" do
    tipo = build :endereco_tipo
    expect(tipo).to be_valid
    tipo.descricao = "Aqui tem 21 caractere"
    expect(tipo).to be_invalid
    expect(tipo.errors[:descricao]).to include "deve possuir até 20 caracteres"
  end

  describe "escopos" do
    let!(:tipo_1) { create(:endereco_tipo) }
    let!(:tipo_2) { create(:endereco_tipo) }
    let!(:tipo_3) { create(:endereco_tipo) }

    describe ".descricao" do
      let!(:tipo_4) { create(:endereco_tipo, descricao: "Nao tenho descricao") }
      it "retorna tipos de endereco pela descricao" do
        expect(EnderecoTipo.descricao("Endereco")).to     include(tipo_1, tipo_2, tipo_3)
        expect(EnderecoTipo.descricao("Endereco")).to_not include(tipo_4)
      end
    end
  end
end
