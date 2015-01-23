json.logradouros do
  json.array! @logradouros do |logradouro|
    json.extract! logradouro, :id, :nome, :titulo_logradouro_id, :logradouro_tipo_id, :municipio_id, :ativo, :nome_popular, :atualizado_em

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

    json.titulo_logradouro(logradouro.titulo_logradouro, :id, :descricao) if logradouro.titulo_logradouro
    json.tipo_logradouro(logradouro.tipo_logradouro, :id, :descricao) if logradouro.tipo_logradouro
  end
end

json.page do
  json.total @total
  json.current_page @logradouros.current_page
  json.total_pages @logradouros.total_pages
  json.first_page @logradouros.first_page?
  json.last_page @logradouros.last_page?
end if @total
