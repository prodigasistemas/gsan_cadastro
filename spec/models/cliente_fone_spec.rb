require "rails_helper"

describe ClienteFone do
  describe "valida" do
    context "padrao" do
      let(:cliente) { create :cliente }
      let!(:fone_1) { create :cliente_fone, cliente_id: cliente.id, padrao: 1 }
      let!(:fone_2) { build  :cliente_fone, cliente_id: cliente.id, padrao: 2 }

      it "somente um telefone pode ser marcado como padrao" do
        expect(fone_2).to be_valid
        fone_2.padrao = 1
        expect(fone_2).to be_invalid
        expect(fone_2.errors[:padrao]).to include "deve ser único"
      end
    end
  end
end
