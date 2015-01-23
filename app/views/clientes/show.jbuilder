json.extract! @cliente,   :id,
                          :orgao_emissor_rg_id,
                          :orgao_emissor_uf_id,
                          :cliente_responsavel_superior_id,
                          :ramo_atividade_id,
                          :profissao_id,
                          :pessoa_sexo_id,
                          :cliente_tipo_id,
                          :nome,
                          :nome_abreviado,
                          :cpf,
                          :rg,
                          :data_emissao_rg,
                          :nascimento,
                          :cnpj,
                          :email,
                          :ativo,
                          :atualizado_em,
                          :vencimento,
                          :acao_cobranca,
                          :nome_mae,
                          :cobranca_acrescimos,
                          :arquivo_texto,
                          :vencimento_mes_seguinte,
                          :gera_fatura_antecipada,
                          :nome_fantasia_conta,
                          :permite_negativacao,
                          :negativacao_periodo

json.pessoa_tipo @cliente.cliente_tipo.pessoa_fisica_juridica
json.profissao @cliente.profissao, :id, :descricao if @cliente.profissao

json.enderecos @cliente.enderecos, partial: "cliente_enderecos/cliente_endereco", as: :endereco
