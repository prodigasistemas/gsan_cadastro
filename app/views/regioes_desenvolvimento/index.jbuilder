json.regioes_desenvolvimento do
  json.array! @regioes_desenvolvimento do |regiao_desenvolvimento|
    json.extract! regiao_desenvolvimento, :id, :nome, :ativo
  end
end

json.page do
  json.total @total
  json.current_page @regioes_desenvolvimento.current_page
  json.total_pages @regioes_desenvolvimento.total_pages
  json.first_page @regioes_desenvolvimento.first_page?
  json.last_page @regioes_desenvolvimento.last_page?
end if @total.present?