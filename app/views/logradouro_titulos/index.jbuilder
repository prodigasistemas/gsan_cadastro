json.logradouro_titulos do
  json.partial! 'logradouro_titulos/logradouro_titulo', collection: @logradouro_titulos, as: :logradouro_titulo
end

json.partial! "shared/page", total: @total, models: @logradouro_titulos
