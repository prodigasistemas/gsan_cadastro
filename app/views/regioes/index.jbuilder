json.regioes do
  json.array! @regioes do |regiao|
    json.extract! regiao, :id, :nome, :ativo
  end
end

json.page do
  json.total @total
  json.current_page @regioes.current_page
  json.total_pages @regioes.total_pages
  json.first_page @regioes.first_page?
  json.last_page @regioes.last_page?
end if @total.present?