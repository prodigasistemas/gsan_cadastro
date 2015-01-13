require "rails_helper"

describe Cep do
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :tipo_id }
  it { should validate_presence_of :municipio }
  it { should validate_presence_of :tipo_logradouro }
  it { should validate_presence_of :logradouro }
end
