require "rails_helper"

describe LogradouroTitulo do
  it { should validate_presence_of    :descricao }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    logradouro_titulo = create :logradouro_titulo
    novo_logradouro_titulo = build :logradouro_titulo
    expect(novo_logradouro_titulo).to be_valid
    novo_logradouro_titulo.descricao = logradouro_titulo.descricao
    expect(novo_logradouro_titulo).to be_invalid
  end

  it "unicabildiade de descricao abreviada" do
    logradouro_titulo = create :logradouro_titulo
    novo_logradouro_titulo = build :logradouro_titulo
    expect(novo_logradouro_titulo).to be_valid
    novo_logradouro_titulo.descricao_abreviada = logradouro_titulo.descricao_abreviada
    expect(novo_logradouro_titulo).to be_invalid
  end

  it "unicabildiade de descricao abreviada completa" do
    logradouro_titulo = create :logradouro_titulo
    novo_logradouro_titulo = build :logradouro_titulo
    expect(novo_logradouro_titulo).to be_valid
    novo_logradouro_titulo.descricao_abreviada_completa = logradouro_titulo.descricao_abreviada_completa
    expect(novo_logradouro_titulo).to be_invalid
  end

  it "tamanho da descricao" do
    logradouro_titulo = build :logradouro_titulo
    expect(logradouro_titulo).to be_valid
    logradouro_titulo.descricao = "a" * 26
    expect(logradouro_titulo).to be_invalid
    expect(logradouro_titulo.errors[:descricao]).to include "deve possuir até 25 caracteres"
  end

  it "tamanho da descricao abreviada" do
    logradouro_titulo = build :logradouro_titulo
    expect(logradouro_titulo).to be_valid
    logradouro_titulo.descricao_abreviada = "a" * 6
    expect(logradouro_titulo).to be_invalid
    expect(logradouro_titulo.errors[:descricao_abreviada]).to include "deve possuir até 5 caracteres"
  end

  it "tamanho da descricao abreviada completa" do
    logradouro_titulo = build :logradouro_titulo
    expect(logradouro_titulo).to be_valid
    logradouro_titulo.descricao_abreviada_completa = "a" * 14
    expect(logradouro_titulo).to be_invalid
    expect(logradouro_titulo.errors[:descricao_abreviada_completa]).to include "deve possuir até 13 caracteres"
  end

  describe "escopos" do
    let!(:logradouro_titulo_1) { create(:logradouro_titulo) }
    let!(:logradouro_titulo_2) { create(:logradouro_titulo) }
    let!(:logradouro_titulo_3) { create(:logradouro_titulo) }
    let!(:logradouro_titulo_4) { create(:logradouro_titulo, descricao: "Nao tenho descricao",
                                                        descricao_abreviada: "N",
                                                        descricao_abreviada_completa: "Nao tem") }

    describe ".descricao" do
      it "retorna titulos de logradouro pela descricao" do
        expect(LogradouroTitulo.descricao("titulo")).to     include(logradouro_titulo_1, logradouro_titulo_2, logradouro_titulo_3)
        expect(LogradouroTitulo.descricao("titulo")).to_not include(logradouro_titulo_4)
      end
    end

    describe ".descricao_abreviada" do
      it "retorna titulos de logradouro pela descricao abreviada" do
        expect(LogradouroTitulo.descricao_abreviada("a")).to     include(logradouro_titulo_1, logradouro_titulo_2, logradouro_titulo_3)
        expect(LogradouroTitulo.descricao_abreviada("a")).to_not include(logradouro_titulo_4)
      end
    end

    describe ".descricao_abreviada" do
      it "retorna titulos de logradouro pela descricao abreviada" do
        expect(LogradouroTitulo.descricao_abreviada_completa("comp")).to     include(logradouro_titulo_1, logradouro_titulo_2, logradouro_titulo_3)
        expect(LogradouroTitulo.descricao_abreviada_completa("comp")).to_not include(logradouro_titulo_4)
      end
    end
  end
end
