require "rails_helper"

describe Coeficiente do
  describe "associacoes" do
    it { is_expected.to belong_to(:contrato_medicao)
          .with_foreign_key(:cmed_id) }
  end

  describe "validacoes" do
    it { is_expected.to validate_presence_of(:coeficiente) }
    it { is_expected.to validate_presence_of(:ligacao_agua_id) }
  end
end
