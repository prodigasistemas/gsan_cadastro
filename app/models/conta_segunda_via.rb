class ContaSegundaVia

  require 'barby'
  require 'barby/barcode/code_25_interleaved'
  require 'barby/outputter/png_outputter'
  require 'chunky_png'

  attr_accessor :debito_automatico,
                :matricula, :cliente, :cliente_responsavel, :cpf_cnpj, :referencia, :vencimento, :inscricao, :grupo,
                :endereco_imovel, :endereco_entrega,
                :leitura_atual, :leitura_anterior, :data_leitura_atual, :data_leitura_anterior,
                :leitura_informada_atual, :leitura_informada_anterior, :data_leitura_informada_atual, :data_leitura_informada_anterior,
                :data_proxima_leitura, :consumo_faturado, :consumo_dias, :consumo_media,
                :consumo_1, :consumo_2, :consumo_3, :consumo_4, :consumo_5, :consumo_6, :consumo_tipo,
                :situacao_agua, :situacao_esgoto, :hidrometro, :economias,
                :mensagem_fixa_1, :mensagem_fixa_2, :mensagem_fixa_3, :mensagem_1, :mensagem_2, :mensagem_3, :mensagem_anormalidade, :mensagem_debitos, :mensagem_quitacao,
                :servicos, :valor_total,
                :agencia_nome, :agencia_telefone, :agencia_email,
                :padrao_turbidez, :padrao_cor, :padrao_cloro, :padrao_fluor, :padrao_coliformes_totais, :padrao_coliformes_termotolerantes,
                :valor_medio_turbidez, :valor_medio_cor, :valor_medio_cloro, :valor_medio_fluor, :valor_medio_coliformes_totais, :valor_medio_coliformes_termotolerantes,
                :valor_conforme_turbidez, :valor_conforme_cor, :valor_conforme_cloro, :valor_conforme_fluor, :valor_conforme_coliformes_totais, :valor_conforme_coliformes_termotolerantes,
                :impostos_descricao, :impostos_percentual, :impostos_valor_base, :impostos_valor,
                :empresa_nome, :empresa_nome_abreviado, :empresa_cnpj, :empresa_site, :empresa_descricao_aplicativo, :empresa_telefone_aplicativo, :empresa_callcenter,
                :usuario, :codigo_barras_formatado, :codigo_barras, :conta_paga, :data_pagamento, :situacao_conta
  
  def initialize(options = {})
    return if options.nil?

    @path                                           = 'public/contas_segunda_via'
    @file_name                                      = options[:nomeArquivo]

    @debito_automatico                              = options[:codigoDebitoAutomatico]    
    @matricula                                      = options[:matricula]
    @cliente                                        = options[:cliente]
    @cliente_responsavel                            = montar_responsavel(options[:clienteResponsavel])
    @cpf_cnpj                                       = options[:cpfCnpj]
    @referencia                                     = options[:referencia]
    @vencimento                                     = options[:vencimento]
    @inscricao                                      = options[:inscricao]
    @grupo                                          = options[:grupo]
    
    @endereco_imovel                                = options[:enderecoImovel]
    @endereco_entrega                               = options[:enderecoEntrega]

    @data_leitura_anterior                          = options[:dataLeituraAnterior]
    @leitura_anterior                               = options[:leituraAnterior]
    @data_leitura_atual                             = options[:dataLeituraAtual]
    @leitura_atual                                  = options[:leituraAtual]
    @data_leitura_informada_anterior                = options[:dataLeituraInformadaAnterior]
    @leitura_informada_anterior                     = options[:leituraInformadaAnterior]
    @data_leitura_informada_atual                   = options[:dataLeituraInformadaAtual]
    @leitura_informada_atual                        = options[:leituraInformadaAtual]
    @data_proxima_leitura                           = options[:dataProximaLeitura]

    @consumo_faturado                               = options[:consumoFaturado]
    @consumo_dias                                   = options[:consumoDias]
    @consumo_media                                  = options[:consumoMedia]

    @consumo_1                                      = options[:consumoMes1]
    @consumo_2                                      = options[:consumoMes2]
    @consumo_3                                      = options[:consumoMes3]
    @consumo_4                                      = options[:consumoMes4]
    @consumo_5                                      = options[:consumoMes5]
    @consumo_6                                      = options[:consumoMes6]
    @consumo_tipo                                   = options[:consumoTipo]

    @situacao_agua                                  = options[:situacaoAgua]
    @situacao_esgoto                                = options[:situacaoEsgoto]
    @hidrometro                                     = options[:hidrometro]
    @economias                                      = options[:economias]

    @mensagem_fixa_1                                = options[:mensagemFixa1]
    @mensagem_fixa_2                                = options[:mensagemFixa2]
    @mensagem_fixa_3                                = options[:mensagemFixa3]
    @mensagem_1                                     = options[:mensagem1]
    @mensagem_2                                     = options[:mensagem2]
    @mensagem_3                                     = options[:mensagem3]

    @mensagem_anormalidade                          = options[:mensagemAnormalidade]
    @mensagem_debitos                               = options[:mensagemDebitos]
    @mensagem_quitacao                              = options[:mensagemQuitacao]

    @servicos                                       = montar_servicos(options[:servicos])
    @valor_total                                    = options[:valorTotal]

    @agencia_nome                                   = options[:agenciaNome]
    @agencia_telefone                               = options[:agenciaTelefone]
    @agencia_email                                  = options[:agenciaEmail]
    
    @impostos_descricao                             = options[:impostosDescricao]
    @impostos_percentual                            = options[:impostosPercentual]
    @impostos_valor_base                            = options[:impostosValorBase]
    @impostos_valor                                 = options[:impostosValor]

    @padrao_turbidez                                = options[:padraoTurbidez]
    @padrao_cor                                     = options[:padraoCor]
    @padrao_cloro                                   = options[:padraoCloro]
    @padrao_fluor                                   = options[:padraoFluor]
    @padrao_coliformes_totais                       = options[:padraoColiformesTotais]
    @padrao_coliformes_termotolerantes              = options[:padraoColiformesTermotolerantes]

    @valor_medio_turbidez                           = options[:valorMedioTurbidez]
    @valor_medio_cor                                = options[:valorMedioCor]
    @valor_medio_cloro                              = options[:valorMedioCloro]
    @valor_medio_fluor                              = options[:valorMedioFluor]
    @valor_medio_coliformes_totais                  = options[:valorMedioColiformesTotais]
    @valor_medio_coliformes_termotolerantes         = options[:valorMedioColiformesTermotolerantes]

    @valor_conforme_turbidez                        = options[:valorConformeTurbidez]
    @valor_conforme_cor                             = options[:valorConformeCor]
    @valor_conforme_cloro                           = options[:valorConformeCloro]
    @valor_conforme_fluor                           = options[:valorConformeFluor]
    @valor_conforme_coliformes_totais               = options[:valorConformeColiformesTotais]
    @valor_conforme_coliformes_termotolerantes      = options[:valorConformeColiformesTermotolerantes]
    
    @empresa_nome                                   = options[:empresaNome]
    @empresa_nome_abreviado                         = options[:empresaNomeAbreviado]
    @empresa_cnpj                                   = options[:empresaCnpj]
    @empresa_site                                   = options[:empresaSite]
    @empresa_descricao_aplicativo                   = options[:empresaDescricaoAplicativo]
    @empresa_telefone_aplicativo                    = options[:empresaTelefoneAplicativo]
    @empresa_callcenter                             = options[:empresaCallcenter]

    @usuario                                        = options[:usuario]

    @codigo_barras_formatado                        = options[:codigoBarrasComDigitos]
    @codigo_barras                                  = gerar_codigo_barras(options[:codigoBarras])
    @conta_paga                                     = options[:contaPaga]
    @data_pagamento                                 = options[:dataPagamento]
    @situacao_conta                                 = options[:situacaoConta]
  end

  def salvar(pdf)
    Dir.mkdir(@path) unless File.exists?(@path)

    save_path = Rails.root.join(@path, @file_name)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

  private

  def gerar_codigo_barras(code)
    barcode = Barby::Code25Interleaved.new(code)
    barcode.to_image(height: 50, margin: 5).to_data_url
  end

  def montar_servicos(array)
    servicos = Array.new

    array.each do |servico|
      servicos << ContaSegundaViaServicos.new(servico)
    end

    return servicos
  end

  def montar_responsavel(responsavel)
    '- Responsável: ' + responsavel if not responsavel.blank?
  end

end