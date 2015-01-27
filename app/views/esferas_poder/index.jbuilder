  json.array! @esferas do |esfera|
    json.partial! "esferas_poder/esfera_poder", esfera_poder: esfera
  end
