require 'rails_helper'

describe Recadastramento::Arquivo::Hidrometro do
  let!(:hidrometro) { create(:hidrometro) }
  let!(:hidrometro_marca) { create(:hidrometro_marca) }
  let!(:hidrometro_capacidade) { create(:hidrometro_capacidade) }
  let!(:hidrometro_protecao) { create(:hidrometro_protecao) }

  it '#hidrometro_infos' do
    hidrometro_arquivo = Recadastramento::Arquivo::Hidrometro.new hidrometro, hidrometro_marca, hidrometro_capacidade, hidrometro_protecao

    expect(hidrometro_arquivo.numero_hidrometro).to eq(hidrometro.numero_hidrometro)
    expect(hidrometro_arquivo.descricao_marca).to eq(hidrometro_marca.descricao_marca)
    expect(hidrometro_arquivo.descricao_capacidade).to eq(hidrometro_capacidade.descricao_capacidade)
    expect(hidrometro_arquivo.descricao_protecao).to eq(hidrometro_protecao.descricao_protecao)
    expect(hidrometro_arquivo.possui_medidor).to be true
  end

  it '#hidrometro_infos sem medidor' do
    hidrometro_arquivo = Recadastramento::Arquivo::Hidrometro.new hidrometro

    expect(hidrometro_arquivo.possui_medidor).to be false
  end

  it '#hidrometro_infos com medidor e sem numero' do
    hidrometro.numero_hidrometro = nil
    hidrometro.save

    hidrometro_arquivo = Recadastramento::Arquivo::Hidrometro.new hidrometro, hidrometro_marca, hidrometro_capacidade, hidrometro_protecao

    expect(hidrometro_arquivo.possui_medidor).to be true
  end
end