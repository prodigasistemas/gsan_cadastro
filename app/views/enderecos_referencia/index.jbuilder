json.enderecos_referencia do
  json.array! @enderecos_referencia do |referencia|
    json.partial! "enderecos_referencia/endereco_referencia", endereco_referencia: referencia
  end
end

json.partial! "shared/page", total: @total, models: @enderecos_referencia
