json.bairros do
  json.array! @bairros do |bairro|
    json.extract! bairro, :id, :nome, :municipio_id, :codigo_prefeitura, :codigo, :ativo

    json.municipio(bairro.municipio, :id, :nome) if bairro.municipio
  end
end

json.partial! "shared/page", total: @total, models: @bairros
