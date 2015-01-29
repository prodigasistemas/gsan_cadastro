require 'rails_helper'

describe UnidadeFederacao do
  it { should validate_presence_of   :descricao }
  it { should validate_presence_of   :sigla }
end