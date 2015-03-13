require 'rails_helper'

describe BairroArea do
  it { should validate_presence_of :nome }
  it { should validate_length_of(:nome).is_at_most(40) }
end