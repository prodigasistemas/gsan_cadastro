require 'rails_helper'

describe Filterable do
  let!(:cep_tipo) { create(:cep_tipo) }
  let!(:cep)      { create(:cep, logradouro: "MORUMBI") }
  let!(:cep_2)    { create(:cep, logradouro: 'qualquer outro nome') }
  let(:params)    { { filtro_logradouro: 'MORUMBI' } }

  it "retorna os registros do filtro" do
    ceps = Cep.filter(params)
    expect(ceps.size).to eq(1)
    expect(ceps.first).to eq cep
  end
end
