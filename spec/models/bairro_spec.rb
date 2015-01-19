require "rails_helper"

describe Bairro do
  it { should validate_presence_of :municipio_id }
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :nome }

  describe "deve retornar" do
    it "dois registros" do
      bairros = Bairro.pesquisar(codigo: 55)
      expect(bairros.size).to eq(2)
    end

    it "todos os registros" do
      bairros = Bairro.pesquisar()
      expect(bairros.size).to eq(6)
    end
  end
end
