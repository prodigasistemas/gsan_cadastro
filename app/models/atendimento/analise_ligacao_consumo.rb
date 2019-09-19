class Atendimento::AnaliseLigacaoConsumo < Imovel
  def analise_consumo
    excecoes = ClienteImovel.excecoes self.id

    cadastro = {}

    geral = build_faturamento_rota
    if(!excecoes.blank?)
      rota = excecoes.imovel.rota_alternativa ||= excecoes.imovel.quadra.rota
      
      if(!rota.blank?)
        geral = build_faturamento_rota(rota, rota.faturamento_grupo, rota.empresa)
      end
    end
    cadastro[:geral] = geral

    cadastro
  end

  private 

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