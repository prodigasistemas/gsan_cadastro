require 'rails_helper'

describe Regiao do
  it { should validate_uniqueness_of :nome }
  it { should validate_presence_of   :nome }
  it { should ensure_length_of(:nome).is_at_most(20) }

  it_behaves_like 'ativo'
end