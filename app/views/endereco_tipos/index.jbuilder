json.endereco_tipos do
  json.array! @endereco_tipos do |tipo|
    json.partial! tipo
  end
end

json.partial! "shared/page", total: @total, models: @endereco_tipos
