json.extract! @municipio, :id, :codigo_ibge, :nome, :ativo, :ddd, :regiao_desenvolvimento_id, :micro_regiao_id, :uf_id, :cep_inicial, :cep_final

json.uf(@municipio.uf, :id, :sigla, :descricao) if @municipio.uf
json.micro_regiao(@municipio.micro_regiao, :id, :nome) if @municipio.micro_regiao
json.regiao_desenvolvimento(@municipio.regiao_desenvolvimento, :id, :nome) if @municipio.regiao_desenvolvimento
