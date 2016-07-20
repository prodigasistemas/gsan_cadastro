require "rails_helper"

describe Empresa do
  describe "associacoes" do
    it { is_expected.to have_many(:contrato_medicoes)
          .with_foreign_key(:empr_id) }
  end

  describe "validacoes" do
    [:ativo, :principal, :leitura, :cobranca, :validar_pagamento].each do |field|
      it { is_expected.to validate_inclusion_of(field).in_array([1,2]) }
    end
  end
end
