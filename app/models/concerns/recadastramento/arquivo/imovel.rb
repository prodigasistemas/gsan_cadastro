module Recadastramento
  module Arquivo
    class Imovel < Recadastramento::Base

      attr_accessor :matricula, :classe_social, :codigo_cep, :complemento_endereco,
                    :tipo_operacao, :descricao_logradouro, :nome_bairro, :nome_municipio,
                    :numero_hidrometro, :numero_imovel, :numero_iptu, :numero_moradores,
                    :pontos_utilizacao, :quantidade_animais_domesticos, :quantidade_economias_social,
                    :quantidade_economias_outros, :volume_cisterna, :volume_caixa_dagua, :tipo_uso,
                    :fonte_abastecimento_nome, :quantidade_criancas, :quantidade_adultos,
                    :quantidade_idosos, :quantidade_empregados, :quantidade_alunos, :quantidade_caes,
                    :quantidade_outros, :rota, :ramal_local_instalacao_nome, :situacao_atualizacao_cadastral_nome,
                    :area_construida, :volume_piscina, :codigo_setor_comercial, :cadastro_ocorrencia_nome,
                    :comentarios, :datahora_geracao, :datahora_retorno, :datahora_aprovacao,
                    :datahora_processamento, :percentual_abastecimento
    end
  end
end
