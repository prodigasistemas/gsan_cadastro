module Relatorio
  class Base
    TEXTO_HEADER = "GSAN - Sistema de Gestão de Saneamento"
    TITULO_PADRAO = "Relatório"

    def monta_resumo(attributes)
      return if attributes[:resumo].nil? || attributes[:resumo][:cabecalho].nil?

      keys = attributes[:resumo][:cabecalho].map{|item| item[:name]}

      header = attributes[:resumo][:cabecalho].map{|item| item[:description]}

      retorno = []
      retorno << header

      attributes[:resumo][:dados].each do |row|
        line = []
        keys.each do |key|
          line << row[key.to_sym]
        end
        retorno << line
      end
      retorno
    end

    def monta_dados(attributes)
      return if attributes[:cabecalho].nil? || attributes[:dados].nil?

      cabecalho_keys = attributes[:cabecalho].map { |item| item[:name] }
      attributes[:dados].map do |item|
        cabecalho_keys.map {|key| item[key.to_sym]}
      end
    end

    def dados_ordenados(attributes, limpar_duplicados = false, destacar_totais = false)
      return if attributes[:cabecalho].nil? || attributes[:dados].nil? || attributes[:grupos].nil?

      agrupados = monta_dados(attributes)

      ordenados = totalizar(agrupados, attributes, limpar_duplicados)

      dados_formatados(ordenados, attributes, destacar_totais)
    end

    def totalizar(agrupados, attributes, limpar_duplicados)
      unless attributes[:totalizadores].nil?
        linha_total = totalizar_geral(agrupados, attributes)

        agrupados = subtotalizar(agrupados, attributes, limpar_duplicados)

        agrupados.insert(0, linha_total) if not linha_total.nil?
      end

      agrupados
    end

    def totalizar_geral(agrupados, attributes)
        omitir = attributes[:omitirTotalGeral]
        omitir ||= false
        return if omitir

        total = {}
        indice_grupos, indice_totalizadores = [], []

        attributes[:grupos].each do |grupo|
          indice_grupos << indice(grupo[:name], attributes)
        end

        attributes[:totalizadores].each do |totalizador|
          indice = indice(totalizador[:name], attributes)
          indice_totalizadores << indice
          total[indice] = 0
        end

        agrupados.each do |item|
          indice_totalizadores.each do |coluna_calcular|
            total[coluna_calcular] += formata_valor(item[coluna_calcular], 'us')
          end
        end

        linha_total = Array.new(attributes[:cabecalho].size, '-')
        linha_total[0] = "Total"

        indice_totalizadores.each do |indice|
          linha_total[indice] = formata_valor(total[indice], 'br')
        end

        linha_total
    end

    def subtotalizar(agrupados, attributes, limpar_duplicados)
      unless attributes[:totalizadores].nil?
        subtotal = {}
        indice_grupos, indice_totalizadores = [], []

        attributes[:grupos].each do |grupo|
          indice_grupos << indice(grupo[:name], attributes)
        end

        attributes[:totalizadores].each do |totalizador|
          indice = indice(totalizador[:name], attributes)
          indice_totalizadores << indice
          subtotal[indice] = 0
        end

        subtotal_zerado = subtotal.clone

        indice_grupos.reverse_each do |j|
          i = 0
          posicao_inserir = -1

          while true
            item_atual = agrupados[i]

            coluna_atual_buscar = ""
            indice_grupos.each { |indice| coluna_atual_buscar << item_atual[indice] }

            coluna_seguinte_buscar = ""
            if i != agrupados.count - 1
              item_seguinte = agrupados[i + 1]
              indice_grupos.each { |indice| coluna_seguinte_buscar << item_seguinte[indice] }
            end

            if coluna_atual_buscar == coluna_seguinte_buscar
              posicao_inserir = i if posicao_inserir == -1

              unless item_atual.include?("-")
                indice_totalizadores.each do |coluna_calcular|
                  subtotal[coluna_calcular] += formata_valor(item_atual[coluna_calcular], 'us')
                end

                agrupados[i][j] = "" if limpar_duplicados
              end
            else
              if subtotal[indice_totalizadores[0]] > 0
                unless item_atual.include?("-")
                  indice_totalizadores.each do |coluna_calcular|
                    subtotal[coluna_calcular] += formata_valor(item_atual[coluna_calcular], 'us')
                  end
                end

                linha_subtotal = Array.new(attributes[:cabecalho].size, '-')

                indice_grupos.each do |indice|
                  linha_subtotal[indice] = item_atual[indice]
                end

                indice_totalizadores.each do |indice|
                  linha_subtotal[indice] = formata_valor(subtotal[indice], 'br')
                end

                if limpar_duplicados
                  agrupados[i][j] = "" unless item_atual.include?("-")
                end

                agrupados.insert(posicao_inserir, linha_subtotal)

                posicao_inserir = -1

                i += 1

                subtotal = subtotal_zerado.clone
              end
            end

            i += 1

            break if i >= agrupados.count
          end

          indice_grupos.pop
        end
      end

      agrupados
    end

    def dados_formatados(ordenados, attributes, destacar_totais)
      formatar = {}

      attributes[:cabecalho].each_with_index do |cabecalho, indice|
        formatar[indice] = cabecalho[:type] if cabecalho[:type] == 'date'
      end

      unless formatar.empty?
        ordenados.each_with_index do |ordem, linha|
          formatar.each do |coluna, formato|
            if formato == 'date' && checa_data(ordenados[linha][coluna])
              ordenados[linha][coluna] = ordenados[linha][coluna].to_date.strftime("%d/%m/%Y")
            end
          end
        end
      end

      if destacar_totais
        0.upto(ordenados.count - 1) do |i|
          if ordenados[i].include?("-")
            0.upto(ordenados[i].count - 1) do |j|
              ordenados[i][j] = ordenados[i][j] == '-' ? '' : destacar(ordenados[i][j])

              if j < attributes[:grupos].count - 1
                ordenados[i][j] = '' if ordenados[i][j + 1] != '-'
              end
            end
          end
        end
      end

      ordenados
    end

    def checa_data(data)
      Date.parse data rescue nil
    end

    def indice(texto, attributes)
      attributes[:cabecalho].each_with_index do |cabecalho, indice|
        return indice if cabecalho[:name] == texto
      end
    end

    def formata_valor(valor, padrao='br')
      case padrao
      when 'us'
        valor.to_f
      when 'br'
        valor.to_s(:currency, separator: ',', delimiter: '.', precision: 2, unit: '')
      end
    end

    def destacar(texto)
      "<b>#{texto}</b>"
    end
  end
end
