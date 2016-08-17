require 'rails_helper'

describe ClienteRetorno do

  describe "validações" do
    it { should belong_to :pessoa_sexo }
    it { should belong_to :unidade_federacao }
    it { should belong_to :cliente_tipo }
    it { should belong_to :cliente }
    it { should have_many :cliente_fone_retornos }
  end
end