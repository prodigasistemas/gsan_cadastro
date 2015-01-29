require "rails_helper"

describe OrgaoExpedidorRg do
  it { should validate_presence_of    :descricao }
  it { should validate_presence_of    :descricao_abreviada }
  it_behaves_like 'ativo'

  it "unicabildiade de descricao" do
    orgao_expedidor_rg = create :orgao_expedidor_rg
    novo_orgao_expedidor_rg = build :orgao_expedidor_rg
    expect(novo_orgao_expedidor_rg).to be_valid
    novo_orgao_expedidor_rg.descricao = orgao_expedidor_rg.descricao
    expect(novo_orgao_expedidor_rg).to be_invalid
  end

  it "unicabildiade de descricao abreviada" do
    orgao_expedidor_rg = create :orgao_expedidor_rg
    novo_orgao_expedidor_rg = build :orgao_expedidor_rg
    expect(novo_orgao_expedidor_rg).to be_valid
    novo_orgao_expedidor_rg.descricao_abreviada = orgao_expedidor_rg.descricao_abreviada
    expect(novo_orgao_expedidor_rg).to be_invalid
  end

  it "tamanho da descricao" do
    orgao_expedidor_rg = build :orgao_expedidor_rg
    expect(orgao_expedidor_rg).to be_valid
    orgao_expedidor_rg.descricao = "a" * 51
    expect(orgao_expedidor_rg).to be_invalid
    expect(orgao_expedidor_rg.errors[:descricao]).to include "deve possuir até 50 caracteres"
  end

  it "tamanho da descricao abreviada" do
    orgao_expedidor_rg = build :orgao_expedidor_rg
    expect(orgao_expedidor_rg).to be_valid
    orgao_expedidor_rg.descricao_abreviada = "a" * 7
    expect(orgao_expedidor_rg).to be_invalid
    expect(orgao_expedidor_rg.errors[:descricao_abreviada]).to include "deve possuir até 6 caracteres"
  end

  describe "escopos" do
    let!(:orgao_expedidor_rg_1) { create(:orgao_expedidor_rg) }
    let!(:orgao_expedidor_rg_2) { create(:orgao_expedidor_rg) }
    let!(:orgao_expedidor_rg_3) { create(:orgao_expedidor_rg) }
    let!(:orgao_expedidor_rg_4) { create(:orgao_expedidor_rg, descricao: "Nao tenho descricao",
                                                              descricao_abreviada: "Not") }

    describe ".descricao" do
      it "retorna orgaos expedidores de RG pela descricao" do
        expect(OrgaoExpedidorRg.descricao("orgao")).to     include(orgao_expedidor_rg_1, orgao_expedidor_rg_2, orgao_expedidor_rg_3)
        expect(OrgaoExpedidorRg.descricao("orgao")).to_not include(orgao_expedidor_rg_4)
      end
    end

    describe ".descricao_abreviada" do
      it "retorna orgaos expedidores de RG pela descricao abreviada" do
        expect(OrgaoExpedidorRg.descricao_abreviada("ab")).to     include(orgao_expedidor_rg_1, orgao_expedidor_rg_2, orgao_expedidor_rg_3)
        expect(OrgaoExpedidorRg.descricao_abreviada("ab")).to_not include(orgao_expedidor_rg_4)
      end
    end
  end
end
