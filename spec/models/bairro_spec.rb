require "rails_helper"

describe Bairro do
  it { should validate_presence_of :municipio_id }
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :nome }
end
