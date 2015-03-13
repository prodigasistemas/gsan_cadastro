require 'rails_helper'

describe UnidadeFederacao do
  describe "validações" do
    let!(:unidade_federacao) { create(:unidade_federacao) }

    it { should validate_presence_of :descricao }
    it { should validate_presence_of :sigla }

    it { should validate_uniqueness_of :descricao }
    it { should validate_uniqueness_of :sigla }

    it { should validate_length_of(:descricao).is_at_most(35) }
    it { should validate_length_of(:sigla).is_at_most(2) }
  end
end