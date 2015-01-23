require 'rails_helper'

shared_examples 'ativo' do
  it { should     allow_value(1).for :ativo }
  it { should     allow_value(2).for :ativo }
  it { should_not allow_value(0).for :ativo }
  it { should_not allow_value(3).for :ativo }
end