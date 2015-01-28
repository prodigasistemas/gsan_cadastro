require "rails_helper"

describe EsferaPoder do
  it { should validate_presence_of    :descricao }
  it { should validate_presence_of    :permite_gerar_certidao_negativa_imovel }
  it { should validate_presence_of    :permite_gerar_certidao_negativa_cliente }
  it { should validate_uniqueness_of  :descricao }
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
end
