json.extract! cliente_fone,     :id,
                                :cliente_id,
                                :numero,
                                :ddd,
                                :nome_contato,
                                :ramal,
                                :padrao,
                                :fone_tipo_id,
                                :atualizado_em

json.fone_tipo do
  json.partial! cliente_fone.fone_tipo
end
