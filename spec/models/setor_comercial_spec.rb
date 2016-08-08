require "rails_helper"

describe SetorComercial do
  describe "associacoes" do
    it { is_expected.to have_many(:imoveis)
          .with_foreign_key(:stcm_id) }
    it { is_expected.to have_many(:rotas)
          .with_foreign_key(:stcm_id) }
  end
end
