module API
  module Model
    def atributos
      hash = {}
      attribute_aliases.keys.each do |key|
        hash[key] = self.send(key.to_sym)
      end
      hash
    end
  end
end