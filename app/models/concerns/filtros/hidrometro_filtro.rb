module Filtros
  module HidrometroFiltro
    module ClassMethods
      def filtrar_por(options={})
        return nil if options[:data_inicial].nil? or options[:data_final].nil?

        data_inicial = Date.parse(options[:data_inicial],"%a, %d %m %Y")
        data_final = Date.parse(options[:data_final],"%a, %d %m %Y")

        options[:data_inicial] = data_inicial
        options[:data_final] = data_final

        clausulas = []
        clausulas << "(hidi_dtinstalacaohidrometro >= :data_inicial and hidi_dtinstalacaohidrometro <= :data_final
                or hidi_dtretiradahidrometro >= :data_inicial and hidi_dtretiradahidrometro <= :data_final)"

        clausulas << "imovel.loca_id = :localidade_id" unless options[:localidade_id].blank?
        clausulas << "imovel.stcm_id = :setor_comercial_id" unless options[:setor_comercial_id].blank?
        clausulas << "quadra.rota_id = :rota_id" unless options[:rota_id].blank?
        clausulas << "imovel.qdra_id = :quadra_id" unless options[:quadra_id].blank?
        clausulas << "imovel.imov_nnlote = :numero_lote" unless options[:numero_lote].blank?
        clausulas << "imovel.imov_nnsublote = :numero_sublote" unless options[:numero_sublote].blank?

        executar(clausulas.join(" and "), options)
      end

      def executar(sql, parametros)
        joins("LEFT JOIN cadastro.imovel ON micromedicao.hidrometro_inst_hist.lagu_id = imovel.imov_id")
        .joins("LEFT JOIN cadastro.quadra ON cadastro.imovel.qdra_id = cadastro.quadra.qdra_id")
        .where(sql, parametros)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end