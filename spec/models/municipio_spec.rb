require "rails_helper"

describe Municipio do
  it { should validate_presence_of :codigo_ibge }
  it { should validate_presence_of :ddd }
  it { should validate_presence_of :uf_id }
  it { should validate_presence_of :micro_regiao_id }
  it { should validate_presence_of :regiao_desenvolvimento_id }
  it { should validate_presence_of :nome }
end
