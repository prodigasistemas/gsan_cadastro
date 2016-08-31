require 'csv'

module Recadastramento
  class GeradorCSV
    def initialize dados, nome, options = {}
      @dados     = dados
      @nome      = nome
      @separador = options.fetch(:separador, ";")
    end

    def gerar
      return if @dados.blank?

      gerar_arquivo
    end

    private

    def gerar_arquivo
      caminho   = Rails.root.join("tmp", "#{@nome}.csv")
      metadados = obter_meta(@dados.first)
      cabecalho = metadados.values.flatten

      CSV.open(caminho, "wb", col_sep: @separador) do |csv|
        csv << cabecalho

        @dados.each do |dado|
          csv << obter_info(metadados, dado)
        end

        csv
      end
    end

    def obter_info(metadados, dado)
      [].tap do |info|
        metadados.each_pair do |tipo, atributos|
          objeto = dado.send(tipo)

          atributos.each do |atributo|
            info << normalizar_info(objeto.send(atributo))
          end
        end
      end
    end

    def obter_meta(dado)
      {}.tap do |meta|
        normalizar_campos(dado.instance_variables).each do |variable|
          variaveis_campo = dado.send(variable).instance_variables

          meta.merge!({ variable => normalizar_campos(variaveis_campo).sort })
        end
      end
    end

    def normalizar_info(info)
      info.to_s.strip
    end

    def normalizar_campos(campos)
      campos.map{|campo| campo.to_s.gsub("@","") }
    end
  end
end