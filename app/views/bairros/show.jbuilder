json.extract! @bairro, :id, :codigo, :nome, :ativo, :codigo_prefeitura, :municipio_id

json.municipio(@bairro.municipio, :id, :nome) if @bairro.municipio