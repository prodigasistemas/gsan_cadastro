require "rails_helper"

describe Coeficiente do
  subject{ build(:coeficiente) }

  describe "associacoes" do
    it { is_expected.to belong_to(:contrato_medicao)
          .with_foreign_key(:cmed_id) }
    it { is_expected.to belong_to(:ligacao_agua_situacao)
          .with_foreign_key(:last_id) }
  end

  describe "validacoes" do
    it { is_expected.to validate_presence_of(:coeficiente) }
    it { is_expected.to validate_presence_of(:ligacao_agua_id) }
    it { is_expected.to validate_uniqueness_of(:contrato_medicao_id)
          .scoped_to(:ligacao_agua_id) }
    it { is_expected.to validate_numericality_of(:coeficiente) }
  end
end
