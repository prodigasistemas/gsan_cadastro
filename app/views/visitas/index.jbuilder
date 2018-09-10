json.entidades do
  json.array! @visitas do |visita|
    json.id visita.id
    json.imovel_controle_atualizacao_cadastral_id visita.imovel_controle_atualizacao_cadastral_id
    json.cadastro_ocorrencia_id visita.cadastro_ocorrencia_id
    json.atualizado_em visita.atualizado_em
    json.coordenada_x visita.coordenada_x
    json.coordenada_y visita.coordenada_y
  end
end
