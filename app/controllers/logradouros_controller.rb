class LogradourosController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @logradouros = Logradouro.join.filter(query)
      @total = @logradouros.count
      @logradouros = @logradouros.page(params[:page]).per(20)
    else
      @logradouros = Logradouro.join.all
    end
  end

  def show
    @logradouro = Logradouro.find(params[:id])
  end

  def create
    @logradouro = Logradouro.new logradouro_params

    if @logradouro.save
      render :show
    else
      render json: { errors: @logradouro.errors.full_messages }, status: 422
    end
  end

  def update
    @logradouro = Logradouro.find(params[:id])

    if @logradouro.update logradouro_params
      render :show
    else
      render json: { errors: @logradouro.errors.full_messages }, status: 422
    end
  end

  private

  def logradouro_params
    params.require(:logradouro).permit(:nome, :titulo_logradouro_id, :logradouro_tipo_id,
                                        :municipio_id, :ativo, :nome_popular,
                                        logradouro_ceps_attributes: [:id, :ativo, :cep_id, :_destroy],
                                        logradouro_bairros_attributes: [:id, :bairro_id, :_destroy]
                                        )
  end
end
