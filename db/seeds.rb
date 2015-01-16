if Rails.env.test?
  Cep.destroy_all
  Municipio.destroy_all
  Bairro.destroy_all
  Logradouro.destroy_all
  LogradouroCep.destroy_all
  LogradouroBairro.destroy_all

  CepTipo.find_or_create_by(descricao: "ÚNICO",      ativo: true)
  cep_tipo = CepTipo.find_or_create_by(descricao: "LOGRADOURO", ativo: true)
  tipo_logradouro = TipoLogradouro.find_or_create_by(descricao: "RUA")
  tipo_logradouro2 = TipoLogradouro.find_or_create_by(descricao: "AV")
  titulo_logradouro = TituloLogradouro.find_or_create_by(descricao: "GOV")
  titulo_logradouro2 = TituloLogradouro.find_or_create_by(descricao: "ALM")

  micro_regiao =  MicroRegiao.find_or_create_by(nome: "BELEM", ativo: true, regiao_id: 2)
                  MicroRegiao.find_or_create_by(nome: "OBIDOS", ativo: true, regiao_id: 2)

  regiao_desenvolvimento =  RegiaoDesenvolvimento.find_or_create_by(nome: "MARAJO", ativo: true)
                            RegiaoDesenvolvimento.find_or_create_by(nome: "METROPOLITANA", ativo: true)

  uf_para = UnidadeFederacao.find_or_create_by(descricao: "PARA", sigla: "PA")
  uf_acre = UnidadeFederacao.find_or_create_by(descricao: "ACRE", sigla: "AC")

  belem =      Municipio.find_or_create_by(nome: "BELEM", codigo_ibge: 123456, ddd: 91, micro_regiao: micro_regiao, regiao_desenvolvimento: regiao_desenvolvimento, uf: uf_para, ativo: true)
  rio_branco = Municipio.find_or_create_by(nome: "RIO BRANCO", codigo_ibge: 123457, ddd: 81, micro_regiao: micro_regiao, regiao_desenvolvimento: regiao_desenvolvimento, uf: uf_acre, ativo: true)

  Bairro.find_or_create_by(nome: "UMARIZAL", ativo: true, codigo: 66, municipio_id: belem.id)
  Bairro.find_or_create_by(nome: "PEDREIRA", ativo: true, codigo: 55, municipio_id: belem.id)
  Bairro.find_or_create_by(nome: "NAZARE", ativo: true, codigo: 77, municipio_id: belem.id)
  Bairro.find_or_create_by(nome: "CONQUISTA", ativo: true, codigo: 55, municipio_id: rio_branco.id)
  Bairro.find_or_create_by(nome: "CALADIM", ativo: true, codigo: 77, municipio_id: rio_branco.id)
  Cep.find_or_create_by(codigo: "66050380", cep_tipo: cep_tipo, municipio: "BELEM", logradouro: "OLIVEIRA BELO", tipo_logradouro: "LOGRADOURO", uf: "PA")
  Cep.find_or_create_by(codigo: "66666666", cep_tipo: cep_tipo, municipio: "BELEM", logradouro: "MARECHAL MERCHAN", tipo_logradouro: "LOGRADOURO", uf: "PA")

  Logradouro.find_or_create_by(municipio: belem,      titulo_logradouro: titulo_logradouro, tipo_logradouro: tipo_logradouro, nome: "OLIVEIRA BELO", nome_popular: "OLIVEIRA-BELO")
  Logradouro.find_or_create_by(municipio: rio_branco, tipo_logradouro: tipo_logradouro2, nome: "CEARA", nome_popular: "AV CEARA")

end
