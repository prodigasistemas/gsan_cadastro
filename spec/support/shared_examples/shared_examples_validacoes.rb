require 'rails_helper'

shared_examples 'ativo' do
  it { should     allow_value(1).for :ativo }
  it { should     allow_value(2).for :ativo }
  it { should_not allow_value(0).for :ativo }
  it { should_not allow_value(3).for :ativo }
end

shared_examples 'erros de validacao controllers' do
  it "retorna erros de validações" do
    expect(response.status).to eq 422
    expect(json['errors']).to_not be_nil
  end
end