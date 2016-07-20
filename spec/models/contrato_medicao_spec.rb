require "rails_helper"

describe ContratoMedicao do
  subject{ build(:contrato_medicao) }

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
end
