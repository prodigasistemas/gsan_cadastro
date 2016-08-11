require 'rails_helper'

describe ClienteRetorno do
  
  describe "validações" do
    it { should belong_to :pessoa_sexo }
    it { should belong_to :unidade_federacao }
    it { should belong_to :cliente_tipo }
    it { should belong_to :cliente }
    it { should have_many :cliente_fone_retornos }
  end

  describe "#gerencia" do
    context 'quando cliente possui imoveis' do
      let!(:gerencia) { create(:gerencia_regional) }
      let!(:localidade) { create(:localidade, gerencia_regional_id: gerencia.id) }
      let!(:imovel) { create(:imovel, localidade: localidade) }
      let!(:cliente) { create(:cliente) }
      let!(:cliente_imovel) { create(:cliente_imovel, imovel: imovel, cliente: cliente) }
      let!(:cliente_retorno) { create(:cliente_retorno, cliente: cliente) }

      it { expect(cliente_retorno.gerencia).to eq gerencia.nome }  
    end

    context 'quando cliente nao possui imoveis' do
      let!(:cliente) { create(:cliente) }
      let!(:cliente_retorno) { create(:cliente_retorno, cliente: cliente) }

      it { expect(cliente_retorno.gerencia).to eq "" }
    end
  end

end