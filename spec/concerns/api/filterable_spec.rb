require 'rails_helper'

describe Filterable do
  let!(:empresa) { create(:empresa, nome: "empresa") }
  let!(:contrato_medicao1) { create(:contrato_medicao, numero: "847-ABC", empresa: empresa) }
  let!(:contrato_medicao2) { create(:contrato_medicao, numero: "123", empresa: empresa) }

  context "por empresa" do
    subject{ Empresa }

    it{ expect(subject.filter("emp")).to include(empresa) }
    it{ expect(subject.filter("847")).to_not include(empresa) }

    context "com joins" do
      it{ expect(subject.filter("847", ["contrato_medicoes"])).to include(empresa) }
      it{ expect(subject.filter("123", ["contrato_medicoes"])).to include(empresa) }
    end
  end

  context "por contrato_medicao" do
    subject{ ContratoMedicao }

    it{ expect(subject.filter("847")).to include(contrato_medicao1) }
    it{ expect(subject.filter("emp")).to be_empty }

    context "com joins" do
      it{ expect(subject.filter("emp", ["empresa"])).to include(contrato_medicao1) }
      it{ expect(subject.filter("emp", ["empresa"])).to include(contrato_medicao2) }
    end
  end
end
