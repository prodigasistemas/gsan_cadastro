
module Recadastramento
  class Base
    def initialize(*modelos)
      if modelos.any?
        modelos.each { |modelo| carregar_infos(modelo) }
      else
        self.class.instance_methods.each do |method|
          send(method, nil) if method.to_s =~ /\=$/
        end
      end
    end

    private

    def carregar_infos(modelo)
      return if modelo.nil?
      modelo.carregar_relacionamentos if modelo.respond_to?(:carregar_relacionamentos)
      modelo.attribute_aliases.keys.each do |campo|
        self.send("#{campo}=".to_sym, modelo.send(campo.to_sym)) if self.respond_to?(campo.to_sym)
      end
    end
  end
end