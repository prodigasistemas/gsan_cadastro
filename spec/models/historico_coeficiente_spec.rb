require 'rails_helper'

describe HistoricoCoeficiente do
  describe "associacoes" do
    it { is_expected.to belong_to(:coeficiente)
          .with_foreign_key(:cmco_id) }

    it { is_expected.to belong_to(:ligacao_agua_situacao)
          .with_foreign_key(:last_id) }

    it { is_expected.to belong_to(:usuario)
          .with_foreign_key(:usur_id) }
  end

  describe "validacoes" do
    it { is_expected.to validate_presence_of(:coeficiente_id) }
    it { is_expected.to validate_presence_of(:usuario_id) }
    it { is_expected.to validate_presence_of(:ligacao_agua_id) }
    it { is_expected.to validate_presence_of(:numero_coeficiente) }
  end
end