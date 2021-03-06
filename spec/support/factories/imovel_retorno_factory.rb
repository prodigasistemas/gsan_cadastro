FactoryGirl.define do
  factory :imovel_retorno do
    numero_imovel 123
    complemento_endereco 'apto 1'
    pontos_utilizacao 1
    numero_moradores 1
    numero_iptu 123456
    coordenada_x 132
    coordenada_y 123
    numero_hidrometro 1
    numero_medidor_energia 14444
    comentarios 'Outras infos'
    tipo_entrevistado 1
    tipo_operacao 1
    ultima_alteracao { Time.zone.now }
    association :ligacao_agua_situacao
    association :fonte_abastecimento
    association :hidrometro_protecao
    association :imovel
    association :municipio
    nome_municipio 'Belém'
    association :logradouro_tipo
    association :logradouro
    descricao_logradouro 'Avenida'
    nome_bairro 'Pedreira'
    codigo_cep 66000222
    association :localidade
    codigo_setor_comercial 1
    numero_quadra 1
    ligacao_esgoto_situacao_id 1
    ramal_local_instalacao
    association :hidrometro_marca
    association :hidrometro_capacidade
    classe_social 3
    quantidade_animais_domesticos 1
    volume_cisterna 50
    volume_caixa_dagua 50
    volume_piscina 50
    area_construida 100
    tipo_uso 1
    acesso_hidrometro 1
    quantidade_economias_social 1
    quatidade_economias_outra 1
    rota
    percentual_abastecimento 25
  end
end