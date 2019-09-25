class Atendimento::AnaliseLigacaoConsumo < Imovel
  def analise_consumo
    excecoes = ClienteImovel.excecoes self.id

    geral = build_faturamento_rota
    dados_ligacao_agua = {}
    dados_hidrometro_ligacao_agua = {}
    dados_esgoto = {}

    if(!excecoes.blank?)
      rota = excecoes.imovel.rota_alternativa ||= excecoes.imovel.quadra.rota
      
      if(!rota.blank?)
        geral = build_faturamento_rota(rota, rota.faturamento_grupo, rota.empresa)
      end
 
      ligacao_agua = excecoes.imovel.ligacao_agua
      if(ligacao_agua.present?)
        dados_ligacao_agua = build_dados_ligacao_agua(ligacao_agua)
        dados_hidrometro_ligacao_agua = build_hidrometro_ligacao_agua(ligacao_agua)
      end  

      dados_esgoto = build_dados_esgoto excecoes.imovel
    end
    

    cadastro = {}
    cadastro[:geral] = geral
    cadastro[:ligacao] = dados_ligacao_agua
    cadastro[:hidrometro_ligacao] = dados_hidrometro_ligacao_agua
    cadastro[:esgoto] = dados_esgoto

    cadastro
  end

  private 

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

  def build_hidrometro_ligacao_agua(ligacao_agua=nil)
    dados = {}

    return dados unless ligacao_agua.present?

    instalacao = ligacao_agua.hidrometro_instalacao_historico
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