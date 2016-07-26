require "rails_helper"

describe Coeficiente do
  subject{ build(:coeficiente) }

  describe "associacoes" do
    it { is_expected.to belong_to(:contrato_medicao)
          .with_foreign_key(:cmed_id) }
    it { is_expected.to have_many(:historico_coeficientes)
          .with_foreign_key(:cmco_id) }
    it { is_expected.to belong_to(:ligacao_agua_situacao)
          .with_foreign_key(:last_id) }
  end

  describe "validacoes" do
    it { is_expected.to validate_presence_of(:coeficiente) }
    it { is_expected.to validate_presence_of(:ligacao_agua_id) }
    it { is_expected.to validate_uniqueness_of(:contrato_medicao_id)
          .scoped_to(:ligacao_agua_id) }
  end

  describe "salvar histórico" do
    subject!(:coeficiente) { create(:coeficiente, usuario_id: 1) }

    it { expect(coeficiente.historico_coeficientes.first.numero_coeficiente).to eq coeficiente.coeficiente }
    it { expect(coeficiente.historico_coeficientes.first.usuario_id).to eq coeficiente.usuario_id }
    it { expect(coeficiente.historico_coeficientes.first.coeficiente_id).to eq coeficiente.id }
    it { expect(coeficiente.historico_coeficientes.first.ligacao_agua_id).to eq coeficiente.ligacao_agua_id }
  end
end
