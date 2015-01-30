json.logradouros do
  json.array! @logradouros do |logradouro|
    json.extract! logradouro, :id, :nome, :logradouro_titulo_id, :logradouro_tipo_id, :municipio_id, :ativo, :nome_popular, :atualizado_em

    json.municipio do
      json.extract!(logradouro.municipio, :id, :nome)
      json.uf logradouro.municipio.uf, :id, :sigla, :descricao
    end if logradouro.municipio

    json.logradouro_ceps do
      json.array! logradouro.logradouro_ceps do |logradouro_cep|
        json.extract! logradouro_cep, :id
        json.cep logradouro_cep.cep, :id, :codigo
      end
    end

    json.logradouro_bairros do
      json.array! logradouro.logradouro_bairros do |logradouro_bairro|
        json.extract! logradouro_bairro, :id
        json.bairro logradouro_bairro.bairro, :id, :nome
      end
    end

    json.logradouro_titulo(logradouro.logradouro_titulo, :id, :descricao) if logradouro.logradouro_titulo
    json.logradouro_tipo(logradouro.logradouro_tipo, :id, :descricao) if logradouro.logradouro_tipo
  end
end

json.partial! "shared/page", total: @total, models: @logradouros
