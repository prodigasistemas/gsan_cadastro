require "rails_helper"

describe Cep do
  it { should validate_presence_of    :codigo }
  it { should validate_uniqueness_of  :codigo }
  it { should validate_presence_of    :uf }
  it { should validate_presence_of    :tipo_id }
  it { should validate_presence_of    :municipio }
  it { should validate_presence_of    :tipo_logradouro }
  it { should validate_presence_of    :logradouro }

  describe "validacao do range dos ceps do municipio" do
    subject(:cep) { build_stubbed(:cep, codigo: 13902093) }

    context "quando municipio possui cep_final e cep_inicial" do
      context "quando cep não pertence ao intervalo de ceps do município" do
        let(:municipio) { build_stubbed(:municipio, cep_inicial: 13902010, cep_final: 13902065) }

        before do
          cep.municipio_model = municipio
        end

        it "não passa na validação" do
          expect(cep).to_not be_valid
          expect(cep.errors).to include :codigo
        end
      end

      context "quando cep pertence ao intervalo de ceps do município" do
        let(:municipio) { build_stubbed(:municipio, cep_inicial: 13902091, cep_final: 13902095) }

        it_behaves_like "cep passa na validacao"
      end
    end

    context "quando município não possui cep_final" do
      let(:municipio) { build_stubbed(:municipio, cep_final: 13902095) }

      it_behaves_like "cep passa na validacao"
    end

    context "quando município não possui cep_inicial" do
      let(:municipio) { build_stubbed(:municipio, cep_inicial: 13902091) }

      it_behaves_like "cep passa na validacao"
    end

    context "quando município não possui cep_inicial e nem cep_final" do
      let(:municipio) { build_stubbed(:municipio) }

      it_behaves_like "cep passa na validacao"
    end
  end

  describe "codigo" do
    it { should allow_value("12345678").for :codigo }
    it { should_not allow_value("123456789").for :codigo }
    it { should_not allow_value("1234567").for :codigo }
    it { should_not allow_value("1234567d").for :codigo }
  end

  describe "ativo" do
    it { should     allow_value(1).for :ativo }
    it { should     allow_value(2).for :ativo }
    it { should_not allow_value(0).for :ativo }
    it { should_not allow_value(3).for :ativo }
  end

end
