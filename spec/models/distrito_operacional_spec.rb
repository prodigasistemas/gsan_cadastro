require 'rails_helper'

describe DistritoOperacional do
  describe "validacoes" do
    it { should validate_length_of(:descricao).is_at_most(30) }
  end
end