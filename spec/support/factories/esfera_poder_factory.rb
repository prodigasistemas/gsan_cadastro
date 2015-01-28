FactoryGirl.define do
  factory :esfera_poder do
    sequence(:descricao) { |n| "Esfera do Dragão #{n}" }
    ativo 1
    permite_gerar_certidao_negativa_imovel 2
    permite_gerar_certidao_negativa_cliente 2
  end
end
