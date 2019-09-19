class Atendimento::AnaliseLigacaoConsumo < Imovel
  def analise_consumo
    excecoes = ClienteImovel.excecoes self.id

    cadastro = {}

    geral = build_faturamento_rota
    dados_ligacao_agua = build_dados_ligacao_agua

    if(!excecoes.blank?)
      rota = excecoes.imovel.rota_alternativa ||= excecoes.imovel.quadra.rota
      
      if(!rota.blank?)
        geral = build_faturamento_rota(rota, rota.faturamento_grupo, rota.empresa)
      end
 
      if(excecoes.imovel.ligacao_agua.present?)
        dados_ligacao_agua = build_dados_ligacao_agua(excecoes.imovel.ligacao_agua)
      end  
    end
    
    cadastro[:geral] = geral
    cadastro[:dados_ligacao] = dados_ligacao_agua

    cadastro
  end

  private 

  def build_dados_ligacao_agua(ligacao_agua=nil)
    return dados = {data_ligacao: nil, data_corte: nil,  data_religacao: nil, data_supressao: nil, data_restabelecimento: nil, diametro: nil, material: nil, perfil_ligacao: nil, consumo_minimo: nil} if ligacao_agua.blank?

    dados = {}
    dados[:data_ligacao] = ligacao_agua.data_ligacao
    dados[:data_corte] = ligacao_agua.data_corte
    dados[:data_religacao] = ligacao_agua.data_religacao
    dados[:data_supressao] = ligacao_agua.data_supressao
    dados[:data_restabelecimento] = ligacao_agua.data_restabelecimento_agua
    
    diametro = ""
    diametro = ligacao_agua.ligacao_agua_diametro.descricao if ligacao_agua.ligacao_agua_diametro.present?
    dados[:diametro] = diametro

    material = ""
    material = ligacao_agua.ligacao_agua_material.descricao if ligacao_agua.ligacao_agua_material.present?
    dados[:material] = material
    
    perfil = ""
    perfil = ligacao_agua.ligacao_agua_perfil.descricao if ligacao_agua.ligacao_agua_perfil.present?
    dados[:perfil] = perfil
    
    dados[:consumo_minimo] = ligacao_agua.numero_consumo_minimo_agua
    
    dados
  end

  def build_faturamento_rota(rota=nil, faturamento=nil, empresa=nil)      
    return {rota: nil, faturamento: nil, vencimento_faturamento: nil, mes_ano_faturamento: nil, empresa_leiturista: nil, sequencial_rota: nil} if rota.blank?

    r = {}
    r[:rota] = rota.codigo ||= rota.id
    r[:faturamento] = faturamento.id ||= rota.faturamento_grupo_id
    r[:vencimento_faturamento] = faturamento.vencimento
    r[:mes_ano_faturamento] = faturamento.ano_mes_referencia
    r[:empresa_leiturista] = empresa.nome
    r[:sequencial_rota] = self.sequencial_rota_leitura

    r
  end
end