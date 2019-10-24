class Atendimento::PagamentosImovel < Imovel
  def pagamentos
    cadastro = {}    

    contas  = []
    guias   = []
    debitos = []
    contas_historico  = []

    Pagamento.de_contas(self.id).map do |p|
      if(p.tipo_documento_id == DocumentoTipo::TIPO[:debito_a_cobrar])

      elsif(p.tipo_documento_id == DocumentoTipo::TIPO[:guia_pagamento])

      else
        if(p.conta_geral.present? and p.conta_geral.indicador_historico == ContaGeral::INDICADOR[:historico])
          contas_historico << preenche_conta(p)
        else
          contas << preenche_conta(p)
        end
      end
    end

    PagamentoHistorico.de_contas(self.id).map do |p|
 
      if(p.tipo_documento_id == DocumentoTipo::TIPO[:debito_a_cobrar])

      elsif(p.tipo_documento_id == DocumentoTipo::TIPO[:guia_pagamento])

      else
        contas_historico << preenche_conta(p)
      end
    end

    cadastro[:contas]  = contas
    cadastro[:guias]   = guias
    cadastro[:debitos] = debitos
    cadastro[:contas_historico]  = contas_historico

    cadastro
  end

  private 

  def preenche_conta(pagamento)
     conta = {}

     conta[:mes_ano]           = pagamento.ano_mes_referencia

     pagamento_conta = pagamento.conta
     conta[:valor_conta]       = pagamento_conta.valor_total if pagamento_conta.present?
     conta[:valor_pagamento]   = pagamento.valor_pagamento
     conta[:data_pagamento]    = pagamento.data_pagamento

     aviso_bancario = pagamento.aviso_bancario
     if(aviso_bancario.present?)
      conta[:arrecadador] = aviso_bancario.arrecadador.cliente.nome if aviso_bancario.arrecadador.cliente.present?
     else
      conta[:arrecadador] = "JACK JACK"  
     end
     
     situacao_anterior = pagamento.situacao_pagamento_anterior
     conta[:situacao_anterior] = situacao_anterior.descricao_abreviada if situacao_anterior.present?
     conta[:situacao_anterior_dica] = descricao_de situacao_anterior
     
     situacao_atual = pagamento.situacao_pagamento_atual
     conta[:situacao_atual]    = situacao_atual.descricao_abreviada if situacao_atual.present?
     conta[:situacao_atual_dica] = descricao_de situacao_atual

     conta
  end

  def preenche_guia(pagamento)
    guia = {}

    guia[:cliente] = pagamento.cliente.nome if pagamento.cliente.present?
    guia[:tipo_debito] = descricao_de pagamento.debito_tipo
    guia[:valor_guia] = pagamento.guia_pagamento.valor_debito if pagamento.guia_pagamento.present?
    guia[:valor_pagamento] = pagamento.valor_pagamento
    guia[:data_pagamento] = pagamento.data_pagamento
    
    aviso_bancario = pagamento.aviso_bancario
     if(aviso_bancario.present?)
      guia[:arrecadador] = aviso_bancario.arrecadador.cliente.nome if aviso_bancario.arrecadador.cliente.present?
     else
      guia[:arrecadador] = "JACK JACK"  
     end
    
     situacao_anterior = pagamento.situacao_pagamento_anterior
     guia[:situacao_anterior] = situacao_anterior.descricao_abreviada if situacao_anterior.present?
     guia[:situacao_anterior_dica] = descricao_de situacao_anterior
     
     situacao_atual = pagamento.situacao_pagamento_atual
     guia[:situacao_atual]    = situacao_atual.descricao_abreviada if situacao_atual.present?
     guia[:situacao_atual_dica] = descricao_de situacao_atual

  end
end
