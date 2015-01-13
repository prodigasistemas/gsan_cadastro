if Rails.env.test?
  Cep.destroy_all
  Municipio.destroy_all

  CepTipo.find_or_create_by(descricao: "ÚNICO",      ativo: true)
  CepTipo.find_or_create_by(descricao: "LOGRADOURO", ativo: true)
  TipoLogradouro.find_or_create_by(descricao: "RUA")

  uf_para = UnidadeFederacao.find_or_create_by(descricao: "PARA", sigla: "PA")
  belem = Municipio.find_or_create_by(nome: "BELÉM", uf: uf_para, ativo: true, regiao_id: 1, micro_regiao_id: 2)
  Bairro.find_or_create_by(nome: "UMARIZAL", ativo: true, codigo: 66, municipio_id: belem.id)
end
