json.orgaos_expedidores_rg do
  json.array! @orgaos_expedidores_rg do |orgao|
    json.partial! "orgaos_expedidores_rg/orgao_expedidor_rg", orgao_expedidor_rg: orgao
  end
end

json.partial! "shared/page", total: @total, models: @orgaos_expedidores_rg
