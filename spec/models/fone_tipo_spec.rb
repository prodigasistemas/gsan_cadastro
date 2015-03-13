require 'rails_helper'

describe FoneTipo do
  describe "validacoes" do
    it { should validate_length_of(:descricao).is_at_most(20) } 
  end
end