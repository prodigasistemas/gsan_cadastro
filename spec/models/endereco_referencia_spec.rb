require "rails_helper"

describe EnderecoReferencia do
  it { should validate_presence_of    :descricao }
  it { should validate_presence_of    :descricao_abreviada }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    endereco_referencia = create :endereco_referencia
    novo_endereco_referencia = build :endereco_referencia
    expect(novo_endereco_referencia).to be_valid
    novo_endereco_referencia.descricao = endereco_referencia.descricao
    expect(novo_endereco_referencia).to be_invalid
  end

  it "unicabildiade de descricao abreviada" do
    endereco_referencia = create :endereco_referencia
    novo_endereco_referencia = build :endereco_referencia
    expect(novo_endereco_referencia).to be_valid
    novo_endereco_referencia.descricao_abreviada = endereco_referencia.descricao_abreviada
    expect(novo_endereco_referencia).to be_invalid
  end

  it "tamanho da descricao" do
    endereco_referencia = build :endereco_referencia
    expect(endereco_referencia).to be_valid
    endereco_referencia.descricao = "Aqui tem 21 caractere"
    expect(endereco_referencia).to be_invalid
    expect(endereco_referencia.errors[:descricao]).to include "deve possuir até 20 caracteres"
  end

  it "tamanho da descricao abreviada" do
    endereco_referencia = build :endereco_referencia
    expect(endereco_referencia).to be_valid
    endereco_referencia.descricao_abreviada = "Aqui tem 19 caracte"
    expect(endereco_referencia).to be_invalid
    expect(endereco_referencia.errors[:descricao_abreviada]).to include "deve possuir até 18 caracteres"
  end

  describe "escopos" do
    let!(:endereco_referencia_1) { create(:endereco_referencia) }
    let!(:endereco_referencia_2) { create(:endereco_referencia) }
    let!(:endereco_referencia_3) { create(:endereco_referencia) }
    let!(:endereco_referencia_4) { create(:endereco_referencia, descricao: "Nao tenho descricao",
                                                                descricao_abreviada: "Nao tenho tambem") }

    describe ".descricao" do
      it "retorna enderecos de referencia pela descricao" do
        expect(EnderecoReferencia.descricao("Refere")).to     include(endereco_referencia_1, endereco_referencia_2, endereco_referencia_3)
        expect(EnderecoReferencia.descricao("Refere")).to_not include(endereco_referencia_4)
      end
    end

    describe ".descricao_abreviada" do
      it "retorna enderecos de referencia pela descricao abreviada" do
        expect(EnderecoReferencia.descricao_abreviada("Abrevi")).to     include(endereco_referencia_1, endereco_referencia_2, endereco_referencia_3)
        expect(EnderecoReferencia.descricao_abreviada("Abrevi")).to_not include(endereco_referencia_4)
      end
    end
  end
end
