require 'rails_helper'

describe Recadastramento::Arquivo::Cliente do
  let!(:unidade_federacao) { create(:unidade_federacao) }
  let!(:cliente) { create(:cliente) }
  let!(:cliente_retorno) { create(:cliente_retorno, cliente: cliente, unidade_federacao: unidade_federacao) }

  describe "cliente_infos" do
    let(:cliente_arquivo) { Recadastramento::Arquivo::Cliente.new cliente_retorno }

    it { expect(cliente_arquivo.nome_usuario).to eq cliente_retorno.nome }
    it { expect(cliente_arquivo.tipo_pessoa).to eq cliente_retorno.tipo_pessoa }
    it { expect(cliente_arquivo.cpf_cnpj).to eq cliente_retorno.cpf_cnpj }
    it { expect(cliente_arquivo.rg).to eq cliente_retorno.rg }
    it { expect(cliente_arquivo.uf).to eq cliente_retorno.uf }
    it { expect(cliente_arquivo.tipo_sexo).to eq cliente_retorno.tipo_sexo }
    it { expect(cliente_arquivo.telefone).to eq cliente_retorno.telefone }
  end
end