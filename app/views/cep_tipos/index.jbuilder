json.cep_tipos do
  json.array! @cep_tipos do |cep_tipo|
    json.extract! cep_tipo, :id, :descricao, :ativo, :atualizado_em
  end
end

json.partial! "shared/page", total: @total, models: @cep_tipos