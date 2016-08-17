require 'csv'

module Recadastramento
  class GeradorCSV
    def initialize dados, options = {}
      @dados     = dados
      @separador = options.fetch(:separador, ";")
    end

    def gerar
      return if @dados.blank?

      gerar_arquivo
    end

    private

    def gerar_arquivo
      path = Rails.root.join("tmp", "#{Time.zone.now.to_i}.csv")
      meta = obter_meta(@dados.first)

      CSV.open(path, "wb", col_sep: @separador) do |csv|
        csv << meta.values.flatten

        @dados.each do |dado|
          info = []

          meta.each_pair do |tipo, atributos|
            objeto = dado.send(tipo)

            atributos.each do |atributo|
              info << normalizar_info(objeto.send(atributo))
            end
          end

          csv << info
        end

        csv
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