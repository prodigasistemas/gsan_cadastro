require "rails_helper"

describe Rota do
  describe "associacoes" do
    it { is_expected.to belong_to(:setor_comercial)
          .with_foreign_key(:stcm_id) }
    it { is_expected.to belong_to(:empresa)
          .with_foreign_key(:empr_id) }
  end

  describe "validacoes" do
    it { is_expected.to validate_presence_of(:codigo) }
    it { is_expected.to validate_presence_of(:ativo) }
  end
end
