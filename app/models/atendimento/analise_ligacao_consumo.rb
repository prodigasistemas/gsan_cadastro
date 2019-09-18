class Atendimento::AnaliseLigacaoConsumo < Imovel
  def analise_consumo
    excecoes = ClienteImovel.excecoes self.id

    cadastro = {}

    geral = build_faturamento_rota
    if(!excecoes.blank?)
      rota = excecoes.imovel.rota_alternativa
      
      if(!rota.blank?)
        geral = build_faturamento_rota(rota, rota.faturamento_grupo, rota.empresa)
      end
    end
    cadastro[:geral] = geral

    cadastro
  end

  private 

  def build_faturamento_rota(rota_alternativa=nil, faturamento=nil, empresa=nil)      
    return {rota: nil, faturamento: nil, vencimento_faturamento: nil, mes_ano_faturamento: nil, empresa_leiturista: nil, sequencial_rota: nil} if rota_alternativa.blank?

    r = {}
    r[:rota] = rota_alternativa.codigo ||= rota_alternativa.id
    r[:faturamento] = faturamento.id ||= rota_alternativa.faturamento_grupo_id
    
    if(faturamento.vencimento.nil?)
      if(self.quadra.rota.nil?)
        r[:vencimento_faturamento] = nil
      else
        r[:vencimento_faturamento] = self.quadra.rota.faturamento_grupo.vencimento
      end  
    else
      r[:vencimento_faturamento] = faturamento.vencimento
    end

    if(faturamento.ano_mes_referencia.nil?)
      if(self.quadra.rota.nil?)
        r[:mes_ano_faturamento] = nil
      else
        r[:mes_ano_faturamento] = self.quadra.rota.faturamento_grupo.ano_mes_referencia
      end  
    else
      r[:mes_ano_faturamento] = faturamento.ano_mes_referencia
    end

    if(empresa.nome.blank?)
      if(self.quadra.rota.nil?)
        r[:empresa_leiturista] = nil
      else
        r[:empresa_leiturista] = self.quadra.rota.empresa.nome
      end  
    else
      r[:empresa_leiturista] = empresa.nome
    end

    r[:sequencial_rota] = self.sequencial_rota_leitura

    r
  end
end