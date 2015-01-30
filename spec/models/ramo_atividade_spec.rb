require "rails_helper"

describe RamoAtividade do
  it { should validate_presence_of    :codigo }
  it { should validate_presence_of    :descricao }
  it { should validate_uniqueness_of  :codigo }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    ramo_atividade = create :ramo_atividade
    novo_ramo_atividade = build :ramo_atividade
    expect(novo_ramo_atividade).to be_valid
    novo_ramo_atividade.descricao = ramo_atividade.descricao
    expect(novo_ramo_atividade).to be_invalid
  end

  it "tamanho da descricao" do
    ramo_atividade = build :ramo_atividade
    expect(ramo_atividade).to be_valid
    ramo_atividade.descricao = "Aqui tem 31 caracteres 12345678"
    expect(ramo_atividade).to be_invalid
    expect(ramo_atividade.errors[:descricao]).to include "deve possuir até 30 caracteres"
  end

  describe "escopos" do
    let!(:ramo_atividade_1) { create(:ramo_atividade) }
    let!(:ramo_atividade_2) { create(:ramo_atividade) }
    let!(:ramo_atividade_3) { create(:ramo_atividade) }

    describe ".descricao" do
      let!(:ramo_atividade_4) { create(:ramo_atividade, descricao: "Nao tenho descricao") }
      it "retorna ramos de atividade pela descricao" do
        expect(RamoAtividade.descricao("Ramo de a")).to     include(ramo_atividade_1, ramo_atividade_2, ramo_atividade_3)
        expect(RamoAtividade.descricao("Ramo de a")).to_not include(ramo_atividade_4)
      end
    end

    describe ".codigo" do
      it "retorna ramos de atividade pelo codigo" do
        expect(RamoAtividade.codigo(ramo_atividade_1.codigo)).to     include(ramo_atividade_1)
        expect(RamoAtividade.codigo(ramo_atividade_1.codigo)).to_not include(ramo_atividade_2)
        expect(RamoAtividade.codigo(ramo_atividade_1.codigo)).to_not include(ramo_atividade_3)
      end
    end
  end
end
