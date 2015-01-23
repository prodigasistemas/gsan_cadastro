json.micro_regioes do
  json.array! @micro_regioes do |micro_regiao|
    json.extract! micro_regiao, :id, :nome, :ativo

    json.regiao do
      json.extract! micro_regiao.regiao, :id, :nome
    end if micro_regiao.regiao
  end
end

json.page do
  json.total @total
  json.current_page @micro_regioes.current_page
  json.total_pages @micro_regioes.total_pages
  json.first_page @micro_regioes.first_page?
  json.last_page @micro_regioes.last_page?
end if @total.present?