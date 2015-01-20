require 'rails_helper'

describe Filterable do
  let!(:cep)   { create(:cep) }
  let!(:cep_2) { create(:cep, codigo: '66666666', logradouro: 'teste') }

  let(:params) { { filtro_logradouro: 'DA MATA' } }

  it "retorna os registros do filtro" do
    ceps = Cep.filter(params)
    expect(ceps.size).to eq(1)
    expect(ceps.first).to eq cep
  end
end
