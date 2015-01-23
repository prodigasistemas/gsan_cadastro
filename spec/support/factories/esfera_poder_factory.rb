FactoryGirl.define do
  factory :esfera_poder do
    descricao 'do dragão'
    ativo 1
    permite_gerar_certidao_negativa_imovel 2
    permite_gerar_certidao_negativa_cliente 2
  end
end