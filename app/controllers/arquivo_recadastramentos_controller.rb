class ArquivoRecadastramentosController < ApplicationController
  def show
    caminho ="#{Rails.root}/tmp/#{params[:nome_arquivo]}.csv"
    send_file caminho, :type=>"text/csv", :x_sendfile=>true
  end

  def verify
    nome = params[:nome_arquivo]
    caminho ="#{Rails.root}/tmp/#{nome}.csv"

    if File.exists?(caminho)
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :ok
    end
  end

  def create
    empresa = Empresa.find params[:empresa_id]
    data_inicial = params[:data_inicial].to_datetime if params[:data_inicial].present?
    data_final  = params[:data_final].to_datetime if params[:data_final].present?
    usuario_id = params[:usuario_id]

    @nome_arquivo = "#{Time.zone.now.to_i}#{empresa.id}"

    inclusoes = [:hidrometro_marca, :hidrometro_capacidade, :hidrometro_protecao,
      :cliente_retornos, :fonte_abastecimento, :ramal_local_instalacao,
      :imovel_tipo_ocupante_quantidade_retornos, :situacao_atualizacao_cadastral]

    if data_inicial.present? && data_final.present?
      inclusoes << :imovel_controle_atualizacao_cadastral
      irs = empresa.imovel_retornos.includes(inclusoes).where(imovel_controle_atlz_cad: { icac_tmretorno: data_inicial..data_final })
    else
      irs = empresa.imovel_retornos.includes(inclusoes)
    end

    if irs.present?

      historico = HistoricoArquivoRetorno.create(
                                            usuario_id: usuario_id,
                                            empresa: empresa,
                                            situacao: 'pendente'
                                          )

      ArquivoRecadastramentoJob.perform_async(irs, @nome_arquivo, historico)

      render json: { success: true, nome_arquivo: @nome_arquivo, empresa: empresa.nome, historico: historico.atributos }, status: :ok
    else
      render json: { success: false, message: "Empresa #{empresa.nome} não possui dados para gerar o arquivo." }, status: :ok
    end
  end
end