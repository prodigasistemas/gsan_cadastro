require "rails_helper"

describe EsferaPoder do
  it { should validate_presence_of    :descricao }
  it { should validate_presence_of    :permite_gerar_certidao_negativa_imovel }
  it { should validate_presence_of    :permite_gerar_certidao_negativa_cliente }
  it { should validate_uniqueness_of  :descricao }
  it { should validate_length_of(:descricao).is_at_most(30) }
  
  it_behaves_like 'ativo'

  describe "permite_gerar_certidao_negativa_imovel" do
    it { should     allow_value(1).for :permite_gerar_certidao_negativa_imovel }
    it { should     allow_value(2).for :permite_gerar_certidao_negativa_imovel }
    it { should_not allow_value(0).for :permite_gerar_certidao_negativa_imovel }
    it { should_not allow_value(3).for :permite_gerar_certidao_negativa_imovel }
  end

  describe "cobranca_acrescimos" do
    it { should     allow_value(1).for :permite_gerar_certidao_negativa_cliente }
    it { should     allow_value(2).for :permite_gerar_certidao_negativa_cliente }
    it { should_not allow_value(0).for :permite_gerar_certidao_negativa_cliente }
    it { should_not allow_value(3).for :permite_gerar_certidao_negativa_cliente }
  end

  describe "escopos" do
    let!(:esfera_poder_1) { create(:esfera_poder) }
    let!(:esfera_poder_2) { create(:esfera_poder) }
    let!(:esfera_poder_3) { create(:esfera_poder) }

    describe ".descricao" do
      let!(:esfera_poder_4) { create(:esfera_poder, descricao: "Nao tenho descricao") }
      it "retorna esferas do poder pela descricao" do
        expect(EsferaPoder.descricao("Esfera")).to     include(esfera_poder_1, esfera_poder_2, esfera_poder_3)
        expect(EsferaPoder.descricao("Esfera")).to_not include(esfera_poder_4)
      end
    end

    describe ".permite_gerar_certidao_negativa_imovel" do
      let!(:esfera_poder_4) { create(:esfera_poder, permite_gerar_certidao_negativa_imovel: 1) }
      it "retorna esferas do poder pela permite_gerar_certidao_negativa_imovel" do
        expect(EsferaPoder.permite_gerar_certidao_negativa_imovel(2)).to     include(esfera_poder_1, esfera_poder_2, esfera_poder_3)
        expect(EsferaPoder.permite_gerar_certidao_negativa_imovel(2)).to_not include(esfera_poder_4)
      end
    end

    describe ".permite_gerar_certidao_negativa_cliente" do
      let!(:esfera_poder_4) { create(:esfera_poder, permite_gerar_certidao_negativa_cliente: 1) }
      it "retorna esferas do poder pela permite_gerar_certidao_negativa_cliente" do
        expect(EsferaPoder.permite_gerar_certidao_negativa_cliente(2)).to     include(esfera_poder_1, esfera_poder_2, esfera_poder_3)
        expect(EsferaPoder.permite_gerar_certidao_negativa_cliente(2)).to_not include(esfera_poder_4)
      end
    end
  end
end
