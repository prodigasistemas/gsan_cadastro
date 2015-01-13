if Rails.env.test?
  Cep.destroy_all
  Municipio.destroy_all

  CepTipo.find_or_create_by(descricao: "ÚNICO",      ativo: true)
  CepTipo.find_or_create_by(descricao: "LOGRADOURO", ativo: true)
  TipoLogradouro.find_or_create_by(descricao: "RUA")

  micro_regiao = MicroRegiao.find_or_create_by(nome: "BELEM", ativo: true, regiao_id: 2)
  regiao_desenvolvimento = RegiaoDesenvolvimento.find_or_create_by(nome: "MARAJO", ativo: true)

  uf_para = UnidadeFederacao.find_or_create_by(descricao: "PARA", sigla: "PA")
  belem = Municipio.find_or_create_by(nome: "BELÉM", codigo_ibge: 123456, ddd: 91, micro_regiao: micro_regiao, regiao_desenvolvimento: regiao_desenvolvimento, uf: uf_para, ativo: true)
  Bairro.find_or_create_by(nome: "UMARIZAL", ativo: true, codigo: 66, municipio_id: belem.id)
end
