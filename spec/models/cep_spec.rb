require "rails_helper"

describe Cep do
  it { should validate_presence_of    :codigo }
  it { should validate_uniqueness_of  :codigo }
  it { should validate_presence_of    :uf }
  it { should validate_presence_of    :tipo_id }
  it { should validate_presence_of    :municipio }
  it { should validate_presence_of    :tipo_logradouro }
  it { should validate_presence_of    :logradouro }

  describe "codigo" do
    it { should allow_value("12345678").for :codigo }
    it { should_not allow_value("123456789").for :codigo }
    it { should_not allow_value("1234567").for :codigo }
    it { should_not allow_value("1234567d").for :codigo }
  end

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end
end
