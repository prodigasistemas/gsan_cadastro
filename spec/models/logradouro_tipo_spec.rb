require "rails_helper"

describe LogradouroTipo do
  it { should validate_presence_of    :descricao }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    logradouro_tipo = create :logradouro_tipo
    novo_logradouro_tipo = build :logradouro_tipo
    expect(novo_logradouro_tipo).to be_valid
    novo_logradouro_tipo.descricao = logradouro_tipo.descricao
    expect(novo_logradouro_tipo).to be_invalid
  end

  it "unicabildiade de descricao abreviada" do
    logradouro_tipo = create :logradouro_tipo
    novo_logradouro_tipo = build :logradouro_tipo
    expect(novo_logradouro_tipo).to be_valid
    novo_logradouro_tipo.descricao_abreviada = logradouro_tipo.descricao_abreviada
    expect(novo_logradouro_tipo).to be_invalid
  end

  it "unicabildiade de descricao abreviada completa" do
    logradouro_tipo = create :logradouro_tipo
    novo_logradouro_tipo = build :logradouro_tipo
    expect(novo_logradouro_tipo).to be_valid
    novo_logradouro_tipo.descricao_abreviada_completa = logradouro_tipo.descricao_abreviada_completa
    expect(novo_logradouro_tipo).to be_invalid
  end

  it "tamanho da descricao" do
    logradouro_tipo = build :logradouro_tipo
    expect(logradouro_tipo).to be_valid
    logradouro_tipo.descricao = "a" * 21
    expect(logradouro_tipo).to be_invalid
    expect(logradouro_tipo.errors[:descricao]).to include "deve possuir até 20 caracteres"
  end

  it "tamanho da descricao abreviada" do
    logradouro_tipo = build :logradouro_tipo
    expect(logradouro_tipo).to be_valid
    logradouro_tipo.descricao_abreviada = "a" * 4
    expect(logradouro_tipo).to be_invalid
    expect(logradouro_tipo.errors[:descricao_abreviada]).to include "deve possuir até 3 caracteres"
  end

  it "tamanho da descricao abreviada completa" do
    logradouro_tipo = build :logradouro_tipo
    expect(logradouro_tipo).to be_valid
    logradouro_tipo.descricao_abreviada_completa = "a" * 14
    expect(logradouro_tipo).to be_invalid
    expect(logradouro_tipo.errors[:descricao_abreviada_completa]).to include "deve possuir até 13 caracteres"
  end

  describe "escopos" do
    let!(:logradouro_tipo_1) { create(:logradouro_tipo) }
    let!(:logradouro_tipo_2) { create(:logradouro_tipo) }
    let!(:logradouro_tipo_3) { create(:logradouro_tipo) }
    let!(:logradouro_tipo_4) { create(:logradouro_tipo, descricao: "Nao tenho descricao",
                                                        descricao_abreviada: "N",
                                                        descricao_abreviada_completa: "Nao tem") }

    describe ".descricao" do
      it "retorna tipos de logradouro pela descricao" do
        expect(LogradouroTipo.descricao("tipo")).to     include(logradouro_tipo_1, logradouro_tipo_2, logradouro_tipo_3)
        expect(LogradouroTipo.descricao("tipo")).to_not include(logradouro_tipo_4)
      end
    end

    describe ".descricao_abreviada" do
      it "retorna tipos de logradouro pela descricao abreviada" do
        expect(LogradouroTipo.descricao_abreviada("a")).to     include(logradouro_tipo_1, logradouro_tipo_2, logradouro_tipo_3)
        expect(LogradouroTipo.descricao_abreviada("a")).to_not include(logradouro_tipo_4)
      end
    end

    describe ".descricao_abreviada" do
      it "retorna tipos de logradouro pela descricao abreviada" do
        expect(LogradouroTipo.descricao_abreviada_completa("comp")).to     include(logradouro_tipo_1, logradouro_tipo_2, logradouro_tipo_3)
        expect(LogradouroTipo.descricao_abreviada_completa("comp")).to_not include(logradouro_tipo_4)
      end
    end
  end
end
