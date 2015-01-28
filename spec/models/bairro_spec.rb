require "rails_helper"

describe Bairro do
  it { should validate_presence_of :municipio_id }
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :nome }

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end

  describe "deve retornar" do
    let(:unidade_federacao) { create(:unidade_federacao, sigla: 'BA') }
    let(:municipio) { create(:municipio, uf: unidade_federacao) }
    before do
      create(:bairro, codigo: 55)
      create(:bairro, municipio: municipio)
    end

    it "dois registros" do
      bairros = Bairro.pesquisar(codigo: 55)
      expect(bairros.size).to eq(1)
    end

    it "todos os registros" do
      bairros = Bairro.pesquisar()
      expect(bairros.size).to eq(2)
    end
  end
end
