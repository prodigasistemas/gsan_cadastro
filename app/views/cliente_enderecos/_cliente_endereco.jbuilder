json.extract! endereco, :id,
                        :endereco_tipo_id,
                        :logradouro_id,
                        :logradouro_bairro_id,
                        :logradouro_cep_id,
                        :perimetro_inicial_id,
                        :perimetro_final_id,
                        :referencia_id,
                        :cep_id,
                        :bairro_id,
                        :numero,
                        :complemento,
                        :correspondencia,
                        :atualizado_em

json.logradouro do
  json.partial! endereco.logradouro
end if endereco.logradouro

json.logradouro_bairro do
  json.extract! endereco.logradouro_bairro, :id
  json.bairro endereco.logradouro_bairro.bairro, :id, :nome
end if endereco.logradouro_bairro

json.logradouro_cep do
  json.extract! endereco.logradouro_cep, :id
  json.cep endereco.logradouro_cep.cep, :id, :codigo
end if endereco.logradouro_cep

json.perimetro_inicial do
  json.partial! endereco.perimetro_inicial
end if endereco.perimetro_inicial

json.perimetro_final do
  json.partial! endereco.perimetro_final
end if endereco.perimetro_final
