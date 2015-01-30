require "rails_helper"

describe Profissao do
  it { should validate_presence_of    :codigo }
  it { should validate_presence_of    :descricao }
  it { should validate_uniqueness_of  :codigo }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    profissao = create :profissao
    nova_profissao = build :profissao
    expect(nova_profissao).to be_valid
    nova_profissao.descricao = profissao.descricao
    expect(nova_profissao).to be_invalid
  end

  it "tamanho da descricao" do
    profissao = build :profissao
    expect(profissao).to be_valid
    profissao.descricao = "Aqui tem 31 caracteres 12345678"
    expect(profissao).to be_invalid
    expect(profissao.errors[:descricao]).to include "deve possuir até 30 caracteres"
  end

  describe "escopos" do
    let!(:profissao_1) { create(:profissao) }
    let!(:profissao_2) { create(:profissao) }
    let!(:profissao_3) { create(:profissao) }

    describe ".descricao" do
      let!(:profissao_4) { create(:profissao, descricao: "Nao tenho descricao") }
      it "retorna profissoes pela descricao" do
        expect(Profissao.descricao("Profiss")).to     include(profissao_1, profissao_2, profissao_3)
        expect(Profissao.descricao("Profiss")).to_not include(profissao_4)
      end
    end

    describe ".codigo" do
      it "retorna profissoes pelo codigo" do
        expect(Profissao.codigo(profissao_1.codigo)).to     include(profissao_1)
        expect(Profissao.codigo(profissao_1.codigo)).to_not include(profissao_2)
        expect(Profissao.codigo(profissao_1.codigo)).to_not include(profissao_3)
      end
    end
  end
end
