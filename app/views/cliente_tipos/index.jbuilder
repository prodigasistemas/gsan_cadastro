json.cliente_tipos do
  json.array! @cliente_tipos do |tipo|
    json.partial! tipo
  end
end

json.partial! "shared/page", total: @total, models: @cliente_tipos
