if Rails.env.test?
  CepTipo.find_or_create_by(descricao: "ÚNICO",      ativo: true)
  CepTipo.find_or_create_by(descricao: "LOGRADOURO", ativo: true)
  belem = Municipio.find_or_create_by(nome: "BELÉM", ativo: true, regiao_id: 1, micro_regiao_id: 2, uf_id: 2)
  Bairro.find_or_create_by(nome: "UMARIZAL", ativo: true, codigo: 66, municipio_id: belem.id)
  TipoLogradouro.find_or_create_by(descricao: "RUA")
end
