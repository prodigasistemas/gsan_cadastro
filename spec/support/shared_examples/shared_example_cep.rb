require 'rails_helper'

shared_examples 'cep passa na validacao' do
  it "é válido" do
    cep.municipio_model = municipio
    expect(cep).to be_valid
  end
end