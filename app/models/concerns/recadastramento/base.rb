
module Recadastramento
  class Base
    def initialize(*modelos)
      modelos.each { |modelo| carregar_infos(modelo) }
    end

    private

    def carregar_infos(modelo)
      modelo.attribute_aliases.keys.each do |campo|
        self.send("#{campo}=".to_sym, modelo.send(campo.to_sym)) if self.respond_to?(campo.to_sym)
      end
    end
  end
end