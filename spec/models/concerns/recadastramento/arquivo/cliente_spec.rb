require 'rails_helper'

describe Recadastramento::Arquivo::Cliente do
  let!(:cliente) { create(:cliente) }
  let!(:cliente_retorno) { create(:cliente_retorno, cliente: cliente) }

  describe "cliente_infos" do
    let(:cliente_arquivo) { Recadastramento::Arquivo::Cliente.new cliente_retorno }

    it { expect(cliente_arquivo.matricula_usuario).to eq cliente_retorno.id }
    # it { expect(cliente_arquivo.tipo_endereco_reponsavel).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.usuario_responsavel).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.matricula_usuario).to eq cliente_retorno.nome }
    it { expect(cliente_arquivo.nome_usuario).to eq cliente_retorno.nome }
    it { expect(cliente_arquivo.tipo_pessoa).to eq cliente_retorno.tipo_pessoa }
    # it { expect(cliente_arquivo.cpf_cnpj_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.rg_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.uf_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.tipo_sexo_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.telefone_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.celular_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.email_usuario).to eq cliente_retorno.nome }

    # it { expect(cliente_arquivo.matricula_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.nome_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.tipo_pessoa_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.cpf_cnpj_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.rg_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.uf_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.tipo_sexo_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.telefone_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.celular_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.email_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.tipo_logradouro_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.logradouro_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.numero_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.complemento_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.bairro_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.cep_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.municipio_proprietario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.tipo_endereco_proprietario).to eq cliente_retorno.nome }

    # it { expect(cliente_arquivo.usuario_responsavel).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.nome_usuario).to eq cliente_retorno.nome }
    # it { expect(cliente_arquivo.cpf).to eq cliente_retorno.cpf }
    # it { expect(cliente_arquivo.cnpj).to eq cliente_retorno.cnpj }
    # it { expect(cliente_arquivo.email).to eq cliente_retorno.email }
    # it { expect(cliente_arquivo.pessoa_sexo_id).to eq cliente_retorno.pessoa_sexo_id }
    # it { expect(cliente_arquivo.unidade_federacao_id).to eq cliente_retorno.unidade_federacao_id }
    # it { expect(cliente_arquivo.tipo_responsavel).to eq cliente_retorno.nome }
  end
end