require 'rails_helper'

describe RegiaoDesenvolvimento do
  subject{ build(:regiao_desenvolvimento) }

  it { should validate_presence_of :nome }
  it { should validate_uniqueness_of :nome }
  it { should validate_length_of(:nome).is_at_most(20) }

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end
end