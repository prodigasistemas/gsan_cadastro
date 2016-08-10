module Recadastramento
  module Arquivo
    class Imovel < Recadastramento::Base

      attr_accessor :id, :classe_social, :codigo_cep, :complemento_endereco,
                    :tipo_operacao, :descricao_logradouro, :nome_bairro, :nome_municipio,
                    :numero_hidrometro, :numero_imovel, :numero_iptu, :numero_moradores,
                    :pontos_utilizacao, :quantidade_animais_domesticos, :quantidade_economias_social,
                    :quantidade_economias_outros, :volume_cisterna, :volume_caixa_dagua,

                    # ainda nao mapeados
                    :volume_piscina, :codigo_cliente, :inscricao,
                    :rota, :face, :codigo_municipio, :numero_celpa,
                    :tipo_logradouro_imovel, :codigo_logradouro_imovel,
                    :sub_categoria_residenciais, :sub_categoria_comerciais, :sub_categoria_publicas,
                    :sub_categoria_industriais, :area_construida, :tipo_ligacao,
                    :tipo_dormitorio, :fonte_alternativa,
                    :quantidade_criancas, :quantidade_adultos, :quantidade_idosos, :quantidade_empregados,
                    :quantidade_alunos, :quantidade_caes, :quantidade_outros
    end
  end
end
