require 'rails_helper'

describe MicroRegiao do
  let!(:micro_regiao) { create(:micro_regiao) }
  
  it { should validate_uniqueness_of  :nome }
  it { should validate_presence_of :regiao }

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end
end