class EnderecosReferenciaController < ApplicationController
  def index
    if params[:query]
      query = params[:query]
      @enderecos_referencia = EnderecoReferencia.order(:descricao).filter_data(query)

      unless params[:paginado] == "false"
        @total = @enderecos_referencia.count
        @enderecos_referencia = @enderecos_referencia.page(params[:page]).per(params[:per] || 20)
      end
    else
      @enderecos_referencia = EnderecoReferencia.order(:descricao).all
    end
  end

  def show
    @endereco_referencia = EnderecoReferencia.find(params[:id])
  end

  def create
    @endereco_referencia = EnderecoReferencia.new(endereco_referencia_params)

    if @endereco_referencia.save
      render :show
    else
      render json: { errors: @endereco_referencia.errors.full_messages }, status: 422
    end
  end

  def update
    @endereco_referencia = EnderecoReferencia.find(params[:id])

    if @endereco_referencia.update endereco_referencia_params
      render json: {}
    else
      render json: { errors: @endereco_referencia.errors.full_messages }, status: 422
    end
  end

  private

  def endereco_referencia_params
    params.require(:endereco_referencia).permit  :descricao, :descricao_abreviada, :ativo
  end
end
