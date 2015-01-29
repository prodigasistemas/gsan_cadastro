json.logradouro_tipos do
  json.partial! 'logradouro_tipos/logradouro_tipo', collection: @logradouro_tipos, as: :logradouro_tipo
end

json.partial! "shared/page", total: @total, models: @logradouro_tipos
