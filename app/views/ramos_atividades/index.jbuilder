json.ramos_atividade do
  json.partial! 'ramos_atividades/ramo_atividade', collection: @ramos_atividade, as: :ramo_atividade
end

json.partial! "shared/page", total: @total, models: @ramos_atividade
