require 'rails_helper'

describe Regiao do
  it { should validate_uniqueness_of :nome }
  it { should validate_presence_of   :nome }

  it_behaves_like 'ativo'
end