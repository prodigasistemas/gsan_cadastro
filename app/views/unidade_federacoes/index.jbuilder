json.unidade_federacoes do
  json.array! @unidade_federacoes do |unidade_federacao|
  json.partial! "unidade_federacoes/unidade_federacao", unidade_federacao: unidade_federacao
  end
end

json.partial! "shared/page", total: @total, models: @unidade_federacoes