class Atendimento::AnaliseLigacaoConsumo < Imovel
  def analise_consumo
    excecoes = ClienteImovel.excecoes self.id

    geral = build_faturamento_rota
    dados_ligacao_agua = {}
    dados_hidrometro_ligacao_agua = {}
    dados_esgoto = {}
    dados_hidrometro_ligacao_poco = {}

    if(!excecoes.blank?)
      rota = excecoes.imovel.rota_alternativa ||= excecoes.imovel.quadra.rota

      medicao = Imovel.medicao_agua(self, rota.faturamento_grupo.ano_mes_referencia)
      medicao = Imovel.medicao_agua(self, 201905) if medicao.blank?

      if(!rota.blank?)
        geral = build_faturamento_rota(rota, rota.faturamento_grupo, rota.empresa)
      end

      ligacao_agua = excecoes.imovel.ligacao_agua
      if(ligacao_agua.present?)
        dados_ligacao_agua = build_dados_ligacao_agua ligacao_agua
        dados_hidrometro_ligacao_agua = build_hidrometro ligacao_agua
      end  

      dados_esgoto = build_dados_esgoto excecoes.imovel
      dados_hidrometro_ligacao_poco = build_hidrometro excecoes.imovel
    end
    
    cadastro = {}
    cadastro[:geral] = geral
    cadastro[:ligacao] = dados_ligacao_agua
    cadastro[:hidrometro_ligacao] = dados_hidrometro_ligacao_agua
    cadastro[:esgoto] = dados_esgoto
    cadastro[:hidrometro_poco] = dados_hidrometro_ligacao_poco
    cadastro[:medicao_mes_agua] = build_medicao_do_mes medicao
    cadastro[:consumo_do_mes] = build_consumo_do_mes medicao

    cadastro
  end

  private 

  def build_consumo_do_mes(medicao)
    dados = {}

    return dados if medicao.blank?
    
    historico = medicao.consumo_historico.first
    
    consumo_medido = nil
    consumo_faturado = nil
    consumo_rateio = nil
    consumo_medio = nil
    anormalidade_consumo = nil
    percentual_variacao = nil	
    dias_consumo = nil 	
    tipo_consumo = nil

    if historico.present?
      consumo_faturado = historico.numero_consumo_faturado_mes
      consumo_rateio = historico.consumo_rateio
      anormalidade_consumo = descricao_de historico.consumo_anormalidade
      consumo_medio = historico.consumo_medio

      variacao = 0
      dias = 0

      if(medicao.medicao_historico.present?)
        variacao = (consumo_faturado - medicao.medicao_historico.first.consumo_medio_hidrometro) * 100

        data_anterior = medicao.medicao_historico.first.data_leitura_anterior_faturamento 
        data_faturamento = medicao.medicao_historico.first.data_leitura_atual_faturamento        
        dias = (data_faturamento.to_datetime - data_anterior.to_datetime).to_i
      end
      percentual_variacao = variacao    
      dias_consumo = dias 	
      tipo_consumo = descricao_de historico.consumo_tipo
    end

    consumo_medido = medicao.medicao_historico.first.numero_consumo_mes if medicao.medicao_historico.first.present?

    dados[:consumo_medido] = consumo_medido
    dados[:consumo_faturado] = consumo_faturado
    dados[:consumo_rateio] = consumo_rateio
    dados[:consumo_medio] = consumo_medio
    dados[:anormalidade_consumo] = anormalidade_consumo
    dados[:percentual_variacao] = percentual_variacao
    dados[:dias_consumo] = dias_consumo  	
    dados[:tipo_consumo] = tipo_consumo

    dados
  end

  def build_medicao_do_mes(medicao)
    dados = {}

    return dados if medicao.blank?
    
    historico = medicao.medicao_historico.first
    data_anterior = nil
    leitura_anterior = nil
    data_informada = nil
    leitura_informada = nil
    situacao_leitura = nil
    leitura_faturamento = nil
    data_faturamento = nil
    funcionario = nil
    anormalidade_faturamento = nil
    anormalidade_informada = nil
    consumo_medio = nil

    if historico.present?
      data_anterior = historico.data_leitura_anterior_faturamento 
      leitura_anterior = historico.leitura_anterior_faturamento 
      data_informada = historico.data_leitura_atual_informada
      leitura_informada = historico.leitura_atual_informada 
      data_faturamento = historico.data_leitura_atual_faturamento 
      leitura_faturamento = historico.leitura_atual_faturamento 
      situacao_leitura = descricao_de historico.leitura_situacao
      funcionario = historico.funcionario_id
      anormalidade_informada = descricao_de historico.leitura_anormalidade_informada
      anormalidade_faturamento = descricao_de historico.leitura_anormalidade_faturamento
    end

    consumo_medio = medicao.consumo_historico.first.consumo_medio if medicao.consumo_historico.first.present?

    dados[:data_leitura_anterior]    = data_anterior
    dados[:leitura_anterior]         = leitura_anterior
    dados[:data_leitura_informada]   = data_informada
    dados[:leitura_informada]        = leitura_informada
    dados[:data_leitura_faturamento] = data_faturamento
    dados[:leitura_faturamento]      = leitura_faturamento
    dados[:situacao_leitura]         = situacao_leitura  
    dados[:funcionario]              = funcionario
    dados[:anormalidade_informada]   = anormalidade_informada
    dados[:anormalidade_faturamento] = anormalidade_faturamento
    dados[:consumo_medio]            = consumo_medio

    dados
  end

  def build_dados_esgoto(imovel)
    dados = {}

    return dados unless imovel.ligacao_esgoto.present?

    ligacao = imovel.ligacao_esgoto
    dados[:data_ligacao]         = ligacao.data_ligacao
    dados[:diametro]             = descricao_de ligacao.ligacao_esgoto_diametro
    dados[:material]             = descricao_de ligacao.ligacao_esgoto_material
    dados[:perfil]               = descricao_de ligacao.ligacao_esgoto_perfil
    dados[:consumo_minimo]       = ligacao.consumo_minimo
    dados[:percentual_esgoto]    = ligacao.percentual
    dados[:percentual_coleta]    = ligacao.percentual_agua_consumida_coletada
    dados[:indicador_poco]       = descricao_de imovel.poco_tipo
    dados[:condicao_esgotamento] = descricao_de ligacao.ligacao_esgoto_esgotamento
    dados[:caixa_inspecao]       = descricao_de ligacao.ligacao_esgoto_caixa_inspecao
    dados[:destino_dejetos]      = descricao_de ligacao.ligacao_esgoto_destino_dejetos
    dados[:aguas_pluviais]       = descricao_de ligacao.ligacao_esgoto_destino_aguas_pluviais

    dados
  end  

  def build_hidrometro(ligacao=nil)
    dados = {}

    return dados unless ligacao.present?

    instalacao = ligacao.hidrometro_instalacao_historico
    if(instalacao.present?)

      dados[:tipo_medicao]                  = instalacao.medicao_tipo.descricao
      dados[:hidrometro]                    = instalacao.hidrometro.numero_hidrometro
      dados[:data_instalacao]               = instalacao.data_instalacao
      dados[:capacidade]                    = instalacao.hidrometro.hidrometro_capacidade.descricao_capacidade
      dados[:tipo_hidrometro]               = instalacao.hidrometro.hidrometro_tipo.descricao if instalacao.hidrometro.hidrometro_tipo.present?
      dados[:marca_hidrometro]              = instalacao.hidrometro.hidrometro_marca.descricao_marca
      dados[:local_instalacao]              = instalacao.local_instalacao.descricao
      dados[:diametro]                      = instalacao.hidrometro.hidrometro_diametro.descricao
      dados[:protecao]                      = instalacao.hidrometro_protecao.descricao_protecao
      dados[:leitura_instalacao_hidrometro] = instalacao.numero_leitura_instalacao
      dados[:cavalete] = 'Não'
      dados[:cavalete] = 'Sim' if instalacao.indicador_cavalete.present? && instalacao.indicador_cavalete == 1
      dados[:ano_fabricacao]                = instalacao.hidrometro.ano_fabricacao
      dados[:relojoaria]                    = instalacao.hidrometro.hidrometro_relojoaria.descricao if instalacao.hidrometro.hidrometro_relojoaria.present?
      dados[:usuario_instalacao]            = instalacao.usuario_instalacao.nome if instalacao.usuario_instalacao.present?
      dados[:lacre_instalacao]              = instalacao.numero_lacre
    end
    
    dados
  end

  def build_dados_ligacao_agua(ligacao_agua=nil)
    dados = {}

    return dados if ligacao_agua.blank?

    dados[:data_ligacao]          = ligacao_agua.data_ligacao
    dados[:data_corte]            = ligacao_agua.data_corte
    dados[:data_religacao]        = ligacao_agua.data_religacao
    dados[:data_supressao]        = ligacao_agua.data_supressao
    dados[:data_restabelecimento] = ligacao_agua.data_restabelecimento_agua
    dados[:diametro]              = descricao_de ligacao_agua.ligacao_agua_diametro
    dados[:material]              = descricao_de ligacao_agua.ligacao_agua_material
    dados[:perfil]                = descricao_de ligacao_agua.ligacao_agua_perfil
    dados[:consumo_minimo]        = ligacao_agua.numero_consumo_minimo_agua
    
    dados
  end

  def build_faturamento_rota(rota=nil, faturamento=nil, empresa=nil)      
    r = {}

    return r if rota.blank?

    r[:rota]                   = rota.codigo ||= rota.id
    r[:faturamento]            = faturamento.id ||= rota.faturamento_grupo_id
    r[:vencimento_faturamento] = faturamento.vencimento
    r[:mes_ano_faturamento]    = faturamento.ano_mes_referencia
    r[:empresa_leiturista]     = empresa.nome
    r[:sequencial_rota]        = self.sequencial_rota_leitura

    r
  end

  def descricao_de(modelo)
    return nil if modelo.blank?
    
    modelo.descricao
  end
end