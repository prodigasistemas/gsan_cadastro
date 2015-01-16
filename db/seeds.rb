if Rails.env.test?
  Cep.destroy_all
  Municipio.destroy_all
  Bairro.destroy_all
  Logradouro.destroy_all

  CepTipo.find_or_create_by(descricao: "ÚNICO",      ativo: true)
  logradouro = CepTipo.find_or_create_by(descricao: "LOGRADOURO", ativo: true)
  tipo_logradouro = TipoLogradouro.find_or_create_by(descricao: "RUA")
  titulo_logradouro = TituloLogradouro.find_or_create_by(descricao: "GOV")

  micro_regiao =  MicroRegiao.find_or_create_by(nome: "BELEM", ativo: true, regiao_id: 2)
                  MicroRegiao.find_or_create_by(nome: "OBIDOS", ativo: true, regiao_id: 2)

  regiao_desenvolvimento =  RegiaoDesenvolvimento.find_or_create_by(nome: "MARAJO", ativo: true)
                            RegiaoDesenvolvimento.find_or_create_by(nome: "METROPOLITANA", ativo: true)

  uf_para = UnidadeFederacao.find_or_create_by(descricao: "PARA", sigla: "PA")
            UnidadeFederacao.find_or_create_by(descricao: "ACRE", sigla: "AC")

  belem = Municipio.find_or_create_by(nome: "BELEM", codigo_ibge: 123456, ddd: 91, micro_regiao: micro_regiao, regiao_desenvolvimento: regiao_desenvolvimento, uf: uf_para, ativo: true)
  Bairro.find_or_create_by(nome: "UMARIZAL", ativo: true, codigo: 66, municipio_id: belem.id)
  Bairro.find_or_create_by(nome: "PEDREIRA", ativo: true, codigo: 55, municipio_id: belem.id)
  Bairro.find_or_create_by(nome: "NAZARE", ativo: true, codigo: 77, municipio_id: belem.id)
  Cep.create(codigo: "66050380", cep_tipo: logradouro, municipio: "BELEM", logradouro: "OLIVEIRA BELO", tipo_logradouro: "LOGRADOURO", uf: "PA")
end
