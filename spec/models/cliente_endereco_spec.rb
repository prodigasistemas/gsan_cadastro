require 'rails_helper'

describe ClienteEndereco do
  let(:cliente_tipo) { create(:cliente_tipo, :pessoa_fisica) }
  let(:logradouro_cep) { create(:logradouro_cep) }
  let(:logradouro_bairro) { create(:logradouro_bairro) }
  let(:cliente) { create(:cliente, :pessoa_fisica, cliente_tipo: cliente_tipo) }
  let(:cliente_endereco) { 
    create(:cliente_endereco, cliente_id: cliente.id, logradouro_cep: logradouro_cep, logradouro_bairro: logradouro_bairro) 
  }

  it "deve setar cep_id pelo logradouro_cep" do
    expect(cliente_endereco.cep_id).to eq logradouro_cep.cep_id
  end

  it "deve setar bairro_id pelo logradouro_bairro" do
    expect(cliente_endereco.bairro_id).to eq logradouro_bairro.bairro_id
  end
end