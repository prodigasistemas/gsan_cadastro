require "rails_helper"

describe ClienteTipo do
  subject{ build(:cliente_tipo) }

  it { should validate_presence_of    :descricao }
  it { should validate_presence_of    :esfera_poder_id }
  it { should validate_presence_of    :pessoa_fisica_juridica }
  it { should validate_uniqueness_of  :descricao }
  it { should validate_length_of(:descricao).is_at_most(50) }

  it_behaves_like 'ativo'

  describe "#pessoa_tipo" do
    it "retorna PESSA FISICA quando pessoa_fisica_juridica e 1" do
      subject.pessoa_fisica_juridica = 1
      expect(subject.pessoa_tipo).to eql "PESSOA FISICA"
    end

    it "retorna PESSA JURIDICA quando pessoa_fisica_juridica e 2" do
      subject.pessoa_fisica_juridica = 2
      expect(subject.pessoa_tipo).to eql "PESSOA JURIDICA"
    end
  end
end
