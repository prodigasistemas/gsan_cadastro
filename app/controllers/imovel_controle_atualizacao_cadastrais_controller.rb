class ImovelControleAtualizacaoCadastraisController < ApplicationController

  before_action :find_imovel_controle_atualizacao_cadastral, only: [:show, :update]

  def index
    @reprovados = []
    params[:query].delete :per_page if params[:query].present?
    params[:query].delete :page if params[:query].present?

    if params[:query].present? and params[:query][:reprovados].present?
      @reprovados = ImovelControleAtualizacaoCadastral.reprovados_filtro(params[:query])
      if @reprovados.try(:any?)
        @total = @reprovados.count
        render json: { entidades: @reprovados.map {|rep| Recadastramento::ReprovadoDto.new(rep) },
                       total: @total }, status: :ok
      else
        render json: { entidades: [], total: 0 }, status: :not_found
      end
    else
      render json: { entidades: [], total: 0 }, status: :not_found
    end
  end

  def show
    @imovel_controle_atualizacao_cadastral = ImovelControleAtualizacaoCadastral.find_by(imovel_id: params[:id]) if @imovel_controle_atualizacao_cadastral.nil?
    if @imovel_controle_atualizacao_cadastral
      render json: { entidade: @imovel_controle_atualizacao_cadastral.atributos }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def update
    if @imovel_controle_atualizacao_cadastral.atualizar(imovel_controle_atualizacao_cadastral_params[:situacao_atualizacao_cadastral_id],
                                                        imovel_controle_atualizacao_cadastral_params[:revisoes] || [])
      render json: { entidade: @imovel_controle_atualizacao_cadastral.atributos }, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private

    def find_imovel_controle_atualizacao_cadastral
      @imovel_controle_atualizacao_cadastral = ImovelControleAtualizacaoCadastral.find_by_id params[:id]
    end

    def imovel_controle_atualizacao_cadastral_params
      params.require(:imovel_controle_atualizacao_cadastral).permit(:id, :imovel_id, :situacao_atualizacao_cadastral_id, :revisoes => [])
    end

end
