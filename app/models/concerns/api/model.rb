module API
  module Model
    def atributos(referer=nil)
      atributos([], referer)
    end

    def atributos(params=[], referer=nil)
      referencia(referer || self)
      begin
        new_params = self.as_json(only: :none, methods: params)
      rescue => e
        logger.warn "[ERROR] #{e}"
        new_params = {}
      end
      hash = {}
      attribute_aliases.keys.each do |key|
        hash[key] = self.send(key.to_sym)
      end
      hash.merge(transform_params(new_params))
    end

    private

    def transform_params(params)
      new_params = {}
      params.each do |key, value|
        next if key == referencia
        if value.is_a? Array
          new_params[key] = value.map{ |v| v.atributos(referencia) if v.respond_to? :atributos }
        else
          if value.respond_to? :atributos
            new_params[key] = value.atributos(referencia)
          else
            new_params[key] = value
          end
        end
      end
      new_params
    end

    def referencia(refer=nil)
      @objeto_referencia = refer.is_a?(String) ? refer : refer.class.to_s.underscore.downcase unless refer.nil?
      @objeto_referencia
    end

    module ClassMethods
      def buscar(query={})
        page      = fetch_page(:page, query, 1)
        per_page  = fetch_page(:per_page, query, 50)
        query     = check_params(query)

        return [] if query.blank?

        where(query).page(page).per(per_page)
      end

      def check_params(query)
        {}.tap do |params|
          query.each_pair do |key, value|
            value = check_params(value) if complex_params?(value)

            next if value.blank? || [:page, :per_page].include?(key.to_sym)

            params.merge!({ key => value })
          end
        end
      end

      def inserir_varios(dados, id: :id)
        pk      = self.primary_key
        last_id = self.maximum(pk)
        last_id = 0 unless last_id

        dados.map!{|dado| last_id+=1; dado.merge({ pk => last_id }) }

        self.bulk_insert(set_size: dados.size, values: dados)

        dados
      end

      def fetch_page(key, hash, default_value)
        return default_value unless hash[key].present?

        hash[key]
      end

      def complex_params?(value)
        [Hash, ActionController::Parameters].include?(value.class)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end