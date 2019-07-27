require 'rails_helper'

describe Regiao do
  subject{ build(:regiao) }

  it { should validate_uniqueness_of :nome }
  it { should validate_presence_of   :nome }
  it { should validate_length_of(:nome).is_at_most(20) }

  it_behaves_like 'ativo'
end