require "rails_helper"

describe Logradouro do
  it { should validate_presence_of :nome }
  it { should validate_presence_of :logradouro_tipo_id }
  it { should validate_presence_of :municipio_id }
end
