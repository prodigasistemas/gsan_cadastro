json.esferas_poder do
  json.array! @esferas do |esfera|
    json.partial! "esferas_poder/esfera_poder", esfera_poder: esfera
  end
end

json.partial! "shared/page", total: @total, models: @esferas
