json.extract! logradouro, :id, :nome, :titulo_logradouro_id, :logradouro_tipo_id, :municipio_id, :ativo, :nome_popular, :atualizado_em

json.municipio do
  json.extract! logradouro.municipio, :id, :nome
  json.uf logradouro.municipio.uf, :id, :sigla, :descricao
end if logradouro.municipio

json.tipo_logradouro logradouro.tipo_logradouro
json.titulo_logradouro logradouro.titulo_logradouro

json.logradouro_bairros do
  json.array! logradouro.logradouro_bairros do |logradouro_bairro|
    json.extract! logradouro_bairro, :id, :bairro_id

    json.bairro do
      json.extract! logradouro_bairro.bairro, :id, :nome, :codigo
    end
  end
end

json.logradouro_ceps do
  json.array! logradouro.logradouro_ceps do |logradouro_cep|
    json.extract! logradouro_cep, :id, :cep_id, :ativo

    json.cep do
      json.extract! logradouro_cep.cep, :id, :codigo, :uf, :municipio, :bairro, :logradouro, :codigo
    end
  end
end
