require 'rails_helper'

describe Recadastramento::Arquivo::Imovel do
  let!(:imovel_retorno) { create(:imovel_retorno) }

  it '#imovel_infos' do
    imovel_arquivo = Recadastramento::Arquivo::Imovel.new imovel_retorno

    expect(imovel_arquivo.numero_imovel).to eq(imovel_retorno.numero_imovel)
    expect(imovel_arquivo.tipo_operacao).to eq(imovel_retorno.tipo_operacao)
    expect(imovel_arquivo.numero_iptu).to eq(imovel_retorno.numero_iptu)
  end
end