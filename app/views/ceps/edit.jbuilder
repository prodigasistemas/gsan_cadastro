json.cep(@cep, :id, :codigo, :municipio, :uf, :ativo, :intervalo, :logradouro, :tipo_logradouro, :bairro, :tipo_id)

json.cep_tipos(@cep_tipos, :id, :descricao)

json.municipios(@municipios, :id, :nome, :ativo, :atualizado_em)

json.bairros(@bairros, :id, :nome)

json.tipo_logradouros(@tipo_logradouros, :id, :descricao, :descricao_abreviada, :descricao_abreviada_completa, :ativo)
