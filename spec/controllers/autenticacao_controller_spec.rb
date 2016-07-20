require 'rails_helper'

describe AutenticacaoController, type: :controller do
  #senha:123456
  let!(:usuario) { create(:usuario, nome_usuario: 'usuario', senha: 'fEqNCco3Yq9h5ZUglD3CZJT4lBs=') }

  describe "POST create" do
    context "dados validos de autenticacao" do
      let(:params) do
        {
          "nome_usuario"  => "usuario",
          "senha" => "123456"
        }
      end

      before do
        post :create, params
      end

      it "autenticacao realizada com sucesso" do
        expect(response).to be_success
        body = JSON.parse(response.body)
        expect(body['mensagem']).to eql('Autenticacao realizada com sucesso!')
      end
    end

    context "dados incorretos de autenticacao" do
      let(:params) do
        {
          "nome_usuario"  => "usuario",
          "senha" => "senha_nao_confere"
        }
      end

      before do
        post :create, params
      end

      it "autenticacao realizada com sucesso" do
        expect(response).to be_unauthorized
        body = JSON.parse(response.body)
        expect(body).to be_empty
      end
    end
  end
end