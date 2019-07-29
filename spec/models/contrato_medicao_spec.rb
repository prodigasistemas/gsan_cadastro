require "rails_helper"

describe ContratoMedicao do
  subject(:contrato_medicao) { build(:contrato_medicao) }

  describe "associacoes" do
    it { is_expected.to belong_to(:empresa)
          .with_foreign_key(:empr_id) }

    it { is_expected.to have_many(:coeficientes)
          .with_foreign_key(:cmed_id) }
  end

  describe "validacoes" do
    it { is_expected.to validate_presence_of(:empresa_id) }
    it { is_expected.to validate_presence_of(:numero) }
    it { is_expected.to validate_presence_of(:vigencia_inicial) }
    it { is_expected.to validate_uniqueness_of(:numero) }
  end

  describe "#referencia_assinatura" do

    before do
      contrato_medicao.data_assinatura = Date.new(2016, 01, 01)
    end

    it { expect(contrato_medicao.referencia_assinatura).to eq '201601' }

    it do
      contrato_medicao.data_assinatura = Date.new(2016, 11, 01)

      expect(contrato_medicao.referencia_assinatura).to eq '201611'
    end
  end
end
