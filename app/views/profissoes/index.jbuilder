json.profissoes do
  json.array! @profissoes do |profissao|
    json.partial! "profissoes/profissao", profissao: profissao
  end
end

json.partial! "shared/page", total: @total, models: @profissoes
