json.ceps do
  json.array! @ceps do |cep|
    json.extract! cep, :id, :codigo, :municipio, :uf, :ativo, :intervalo, :logradouro, :logradouro_tipo, :bairro, :tipo_id

    json.cep_tipo do
      json.extract! cep.cep_tipo, :id, :descricao
    end if cep.cep_tipo
  end
end

json.page do
  json.total @total
  json.current_page @ceps.current_page
  json.total_pages @ceps.total_pages
  json.first_page @ceps.first_page?
  json.last_page @ceps.last_page?
end
