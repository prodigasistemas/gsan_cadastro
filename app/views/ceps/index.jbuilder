json.ceps do
  json.array! @ceps do |cep|
    json.extract! cep, :id, :codigo, :municipio, :uf, :ativo, :intervalo, :logradouro, :logradouro_tipo, :bairro, :tipo_id

    json.cep_tipo do
      json.extract! cep.cep_tipo, :id, :descricao
    end if cep.cep_tipo
  end
end

json.partial! "shared/page", total: @total, models: @ceps
