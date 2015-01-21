if Rails.env.test?
  Imovel.destroy_all
  Cep.destroy_all
  Municipio.destroy_all
  Bairro.destroy_all
  Logradouro.destroy_all
  LogradouroCep.destroy_all
  LogradouroBairro.destroy_all
  CepTipo.destroy_all
  RegiaoDesenvolvimento.destroy_all
  MicroRegiao.destroy_all
  Regiao.destroy_all
  TipoLogradouro.destroy_all
  TituloLogradouro.destroy_all
  UnidadeFederacao.destroy_all
  EsferaPoder.destroy_all
  ClienteTipo.destroy_all
  OrgaoExpedidorRg.destroy_all
  PessoaSexo.destroy_all
  Profissao.destroy_all
  RamoAtividade.destroy_all
  Cliente.destroy_all
end

if Rails.env.test? && ENV["ACCEPTANCE_TEST"]
  CepTipo.create!(descricao: "ÚNICO",      ativo: 1)
  cep_tipo = CepTipo.create!(descricao: "LOGRADOURO", ativo: 1)
  tipo_logradouro = TipoLogradouro.create!(descricao: "RUA")
  tipo_logradouro2 = TipoLogradouro.create!(descricao: "AV")
  titulo_logradouro = TituloLogradouro.create!(descricao: "GOV")
  titulo_logradouro2 = TituloLogradouro.create!(descricao: "ALM")

  micro_regiao =  MicroRegiao.create!(nome: "BELEM", ativo: 1, regiao_id: 2)
                  MicroRegiao.create!(nome: "OBIDOS", ativo: 1, regiao_id: 2)

  regiao_desenvolvimento =  RegiaoDesenvolvimento.create!(nome: "MARAJO", ativo: 1)
                            RegiaoDesenvolvimento.create!(nome: "METROPOLITANA", ativo: 1)

  uf_para = UnidadeFederacao.create!(descricao: "PARA", sigla: "PA")
  uf_acre = UnidadeFederacao.create!(descricao: "ACRE", sigla: "AC")

  belem =      Municipio.create!(nome: "BELEM", codigo_ibge: 123456, ddd: 91, micro_regiao: micro_regiao, regiao_desenvolvimento: regiao_desenvolvimento, uf: uf_para, ativo: true)
  rio_branco = Municipio.create!(nome: "RIO BRANCO", codigo_ibge: 123457, ddd: 81, micro_regiao: micro_regiao, regiao_desenvolvimento: regiao_desenvolvimento, uf: uf_acre, ativo: true)

  Bairro.create!(nome: "UMARIZAL", ativo: 1, codigo: 66, municipio_id: belem.id)
  Bairro.create!(nome: "PEDREIRA", ativo: 1, codigo: 55, municipio_id: belem.id)
  Bairro.create!(nome: "NAZARE", ativo: 1, codigo: 77, municipio_id: belem.id)
  Bairro.create!(nome: "CONQUISTA", ativo: 1, codigo: 55, municipio_id: rio_branco.id)
  caladim = Bairro.create!(nome: "CALADIM", ativo: 1, codigo: 77, municipio_id: rio_branco.id)
  cep_1 = Cep.create!(codigo: "66050380", cep_tipo: cep_tipo, municipio: "BELEM", logradouro: "OLIVEIRA BELO", tipo_logradouro: "LOGRADOURO", uf: "PA", ativo: 1)
  cep_2 = Cep.create!(codigo: "66666666", cep_tipo: cep_tipo, municipio: "BELEM", logradouro: "MARECHAL MERCHAN", tipo_logradouro: "LOGRADOURO", uf: "PA", ativo: 1)
  cep_3 = Cep.create!(codigo: "77777777", cep_tipo: cep_tipo, municipio: "BELEM", logradouro: "CRAU", tipo_logradouro: "LOGRADOURO", uf: "PA", ativo: 1)

  Logradouro.create!(municipio: belem,      titulo_logradouro: titulo_logradouro, tipo_logradouro: tipo_logradouro, nome: "OLIVEIRA BELO", nome_popular: "OLIVEIRA-BELO", ativo: 1)
  logradouro_ceara = Logradouro.create!(municipio: rio_branco, tipo_logradouro: tipo_logradouro2, nome: "CEARA", nome_popular: "AV CEARA", ativo: 1)

  logradouro_ceara.logradouro_ceps.create cep: cep_3, ativo: 1
  logradouro_ceara.logradouro_bairros.create bairro: caladim

  esfera_poder = EsferaPoder.create! descricao: "MUNICIPAL", ativo: 1, permite_gerar_certidao_negativa_imovel: 1, permite_gerar_certidao_negativa_cliente: 1
  ClienteTipo.create!(descricao: "RESIDENCIAL", pessoa_fisica_juridica: 1, ativo: 1)
  cliente_associacoes = ClienteTipo.create!(descricao: "ASSOCIACOES", pessoa_fisica_juridica: 2, ativo: 1, esfera_poder: esfera_poder)
  OrgaoExpedidorRg.create!(descricao: "EXERCITO", ativo: 1)
  OrgaoExpedidorRg.create!(descricao: "CREA", ativo: 1)
  Profissao.create! descricao: "PROGRAMADOR", ativo: 1, codigo: 10
  PessoaSexo.create! descricao: "MASCULINO", ativo: 1
  PessoaSexo.create! descricao: "FEMININO", ativo: 1
  RamoAtividade.create! descricao: "ACOUGUE", codigo: 11

  Cliente.create! nome: "LABORATORIO ALFAZEMA", cliente_tipo: cliente_associacoes, cnpj: 37217098000143, negativacao_periodo: 2, permite_negativacao: 2, nome_fantasia_conta: 2, ativo: 1
end
