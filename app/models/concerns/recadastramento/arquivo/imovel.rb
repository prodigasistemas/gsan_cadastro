module Recadastramento
  module Arquivo
    class Imovel
      attr_accessor :id, :tipo_operacao, :codigo_cliente, :inscricao,
                    :rota, :face, :codigo_municipio, :numero_iptu, :numero_celpa,
                    :pontos_utilizacao, :numero_moradores, :tipo_logradouro_imovel,
                    :descricao_logradouro, :numero_imovel, :complemento_endereco,
                    :nome_bairro, :codigo_cep, :nome_municipio, :codigo_logradouro_imovel,
                    :sub_categoria_residenciais, :sub_categoria_comerciais, :sub_categoria_publicas,
                    :sub_categoria_industriais, :classe_social, :area_construida, :tipo_ligacao,
                    :quantidade_animais_domesticos, :volume_cisterna, :volume_piscina, :volume_caixa_dagua,
                    :tipo_dormitorio, :fonte_alternativa, :quantidade_economias_social, :quantidade_economias_outros,
                    :quantidade_criancas, :quantidade_adultos, :quantidade_idosos, :quantidade_empregados,
                    :quantidade_alunos, :quantidade_caes, :quantidade_outros, :numero_hidrometro

      attr_accessor :imovel

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
end
