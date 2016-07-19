module API
  module Model
    def atributos(params=[])
      new_params = self.as_json(only: :none, methods: params)
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
        new_params[key] = value.atributos
      end
      new_params
    end
  end
end