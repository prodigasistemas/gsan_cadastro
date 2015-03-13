require "rails_helper"

describe Municipio do
  it { should validate_presence_of :codigo_ibge }
  it { should validate_presence_of :ddd }
  it { should validate_presence_of :uf_id }
  it { should validate_presence_of :micro_regiao_id }
  it { should validate_presence_of :regiao_desenvolvimento_id }
  it { should validate_presence_of :nome }
  it { should validate_length_of(:nome).is_at_most(30) }

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end
end
