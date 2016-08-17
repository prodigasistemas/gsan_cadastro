require 'rails_helper'

describe Recadastramento::Arquivo::Imovel do
  let!(:fonte_abastecimento) { create(:fonte_abastecimento) }
  let!(:imovel_retorno) { create(:imovel_retorno, fonte_abastecimento: fonte_abastecimento) }

  let!(:tipo_ocupante_criancas_retorno) { create(:tipo_ocupante_criancas_retorno, imovel_retorno: imovel_retorno)}
  let!(:tipo_ocupante_adultos_retorno) { create(:tipo_ocupante_adultos_retorno, imovel_retorno: imovel_retorno)}
  let!(:tipo_ocupante_idosos_retorno) { create(:tipo_ocupante_idosos_retorno, imovel_retorno: imovel_retorno)}
  let!(:tipo_ocupante_empregados_retorno) { create(:tipo_ocupante_empregados_retorno, imovel_retorno: imovel_retorno)}
  let!(:tipo_ocupante_alunos_retorno) { create(:tipo_ocupante_alunos_retorno, imovel_retorno: imovel_retorno)}
  let!(:tipo_ocupante_caes_retorno) { create(:tipo_ocupante_caes_retorno, imovel_retorno: imovel_retorno)}
  let!(:tipo_ocupante_outros_retorno) { create(:tipo_ocupante_outros_retorno, imovel_retorno: imovel_retorno)}

  context '#imovel_infos' do
    subject { Recadastramento::Arquivo::Imovel.new imovel_retorno }

    it 'atributos mapeados' do
      expect(subject.numero_imovel).to eq(imovel_retorno.numero_imovel)
      expect(subject.tipo_operacao).to eq(imovel_retorno.tipo_operacao)
      expect(subject.numero_iptu).to eq(imovel_retorno.numero_iptu)
    end

    it 'metodos mapeados' do
      expect(subject.fonte_abastecimento_nome).to eq(imovel_retorno.fonte_abastecimento_nome)
    end

    it 'quantidade de tipo ocupante crianças' do
      expect(subject.quantidade_criancas).to eq(imovel_retorno.quantidade_criancas)
    end

    it 'quantidade de tipo ocupante adultos' do
      expect(subject.quantidade_adultos).to eq(imovel_retorno.quantidade_adultos)
    end

    it 'quantidade de tipo ocupante idosos' do
      expect(subject.quantidade_idosos).to eq(imovel_retorno.quantidade_idosos)
    end

    it 'quantidade de tipo ocupante empregados' do
      expect(subject.quantidade_empregados).to eq(imovel_retorno.quantidade_empregados)
    end

    it 'quantidade de tipo ocupante alunos' do
      expect(subject.quantidade_alunos).to eq(imovel_retorno.quantidade_alunos)
    end

    it 'quantidade de tipo ocupante caes' do
      expect(subject.quantidade_caes).to eq(imovel_retorno.quantidade_caes)
    end

    it 'quantidade de tipo ocupante outros' do
      expect(subject.quantidade_outros).to eq(imovel_retorno.quantidade_outros)
    end
  end
end