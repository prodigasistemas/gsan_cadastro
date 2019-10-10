class Atendimento::DadosCadastral < Imovel
  def dados_cadastrais
    cadastro = {}

    cadastro[:perfil_imovel] = get_perfil_imovel
    cadastro[:area_construida] = get_area_construida
    cadastro[:volume_reservatorio_inferior] = get_volume_reservatorio_inferior
    cadastro[:volume_reservatorio_superior] = get_volume_reservatorio_superior
    cadastro[:piscina_volume_faixa] = get_piscina_volume_faixa
    cadastro[:fonte_abastecimento] = get_fonte_abastecimento
    cadastro[:tipo_poco] = get_tipo_poco
    cadastro[:distrito_operacional] = get_distrito_operacional
    cadastro[:divisao_esgoto] = get_divisao_esgoto
    cadastro[:cadastro_ocorrencia] = get_cadastro_ocorrencia
    cadastro[:anormalidade] = get_anormalidade
    cadastro[:jardim] = get_jardim
    cadastro[:tipo_habitacao] = get_tipo_habitacao
    cadastro[:tipo_construcao] = get_tipo_construcao
    cadastro[:tipo_cobertura] = get_tipo_cobertura
    cadastro[:tipo_propriedade] = get_tipo_propriedade
    cadastro[:data_processamento] = get_data_processamento
    cadastro[:data_geracao_tac] = get_data_geracao_tac
    cadastro[:subcategorias] = get_imovel_subcategorias
    cadastro[:total_economias] = get_total_economias
    cadastro[:pavimento_calcada] = get_pavimento_calcada
    cadastro[:pavimento_rua] = get_pavimento_rua
    cadastro[:imagens] = get_imagens

    cadastro
  end

  private

  def get_imagens
    imgs = []

    imagens.map do |imagem|
      img = {}
      img[:nome_imagem] = imagem.nome_imagem
      img[:caminho_imagem] = imagem.caminho_imagem
      imgs << img
    end

    imgs
  end

  def get_perfil_imovel
    return "" if perfil_imovel.nil?

    perfil_imovel.descricao
  end

  def get_imovel_subcategorias
    subcategorias = []

    return subcategorias if imovel_subcategorias.blank?

    imovel_subcategorias.map do |s|
      break if s.subcategoria.blank?

      sub = {}
      sub[:subcategoria] = s.subcategoria.try(:descricao)
      sub[:categoria] = s.subcategoria.categoria.try(:descricao)
      sub[:qtd_economias] = s.qtd_economias

      subcategorias << sub
    end

    subcategorias
  end

  def get_total_economias
    return "" if imovel_subcategorias.blank?

    imovel_subcategorias.sum(&:qtd_economias)
  end

  def get_area_construida
    return self.area_construida if not self.area_construida.nil?
    return self.area_construida_faixa.medidas if not self.area_construida_faixa.nil?

    return ""
  end

  def get_volume_reservatorio_inferior
    return volume_reservatorio_inferior if not volume_reservatorio_inferior.nil?
    return "" if faixa_reservatorio_inferior.nil?

    faixa_reservatorio_inferior.medidas
  end

  def get_volume_reservatorio_superior
    return volume_reservatorio_superior if not volume_reservatorio_superior.nil?
    return "" if faixa_reservatorio_superior.nil?

    faixa_reservatorio_superior.medidas
  end

  def get_piscina_volume_faixa
    return volume_piscina if not volume_piscina.nil?
    return "" if piscina_volume_faixa.nil?

    piscina_volume_faixa.medidas
  end

  def get_fonte_abastecimento
    return "" if fonte_abastecimento.nil?

    fonte_abastecimento.descricao
  end

  def get_tipo_poco
    return "" if poco_tipo.nil?

    poco_tipo.descricao
  end

  def get_distrito_operacional
    return "" if quadra_face.nil?
    return "" if quadra_face.distrito_operacional.nil?

    quadra_face.distrito_operacional.descricao
  end

  def get_divisao_esgoto
    return "" if quadra_face.nil?
    return "" if quadra_face.bacia.nil?
    return "" if quadra_face.bacia.sistema_esgoto.nil?
    return "" if quadra_face.bacia.sistema_esgoto.divisao_esgoto.nil?

    quadra_face.bacia.sistema_esgoto.divisao_esgoto.descricao
  end

  def get_pavimento_calcada
    return "" if pavimento_calcada.nil?

    pavimento_calcada.descricao
  end

  def get_pavimento_rua
    return "" if pavimento_rua.nil?

    pavimento_rua.descricao
  end

  def get_cadastro_ocorrencia
    return "" if cadastro_ocorrencia.nil?

    cadastro_ocorrencia.descricao
  end

  def get_anormalidade
    return "" if anormalidade.nil?

    anormalidade.descricao
  end

  def get_jardim
    return "" if jardim.nil?
    return "SIM" if jardim == 1

    "NÃO"
  end

  def get_tipo_habitacao
    return "" if tipo_habitacao.nil?

    tipo_habitacao.descricao
  end

  def get_tipo_construcao
    return "" if tipo_construcao.nil?

    tipo_construcao.descricao
  end

  def get_tipo_cobertura
    return "" if tipo_cobertura.nil?

    tipo_cobertura.descricao
  end

  def get_tipo_propriedade
    return "" if tipo_propriedade.nil?

    tipo_propriedade.descricao
  end

  def get_data_processamento
    atualizacao = atualizacoes_cadastrais.last

    return "" if atualizacao.nil?

    atualizacao.tempo_processamento
  end

  def get_data_geracao_tac
    return "" if termo_atualizacao_comunicados.nil?
    tacs = termo_atualizacao_comunicados.where(tipo_comunicado: 1)

    return "" if tacs.empty?
    tacs.last.data_geracao
  end
end