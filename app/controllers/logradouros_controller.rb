class LogradourosController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      query[:nome] = nil

      @logradouros = Logradouro.where(query.reject! { |k, v| v.blank? })
      @logradouros = @logradouros.where("UPPER(logr_nmlogradouro) LIKE ?", "%#{params[:query][:nome].upcase}%") if params[:query][:nome]

      @total = @logradouros.count
      @logradouros = @logradouros.page(params[:page]).per(20)
    else
      @logradouros = Logradouro.all
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
      render json: { errors: @cep.errors.full_messages }, status: 422
    end
  end

  private

  def logradouro_params
    params.require(:logradouro).permit(:nome, :titulo_logradouro_id, :logradouro_tipo_id,
                                        :municipio_id, :ativo, :nome_popular,
                                        logradouro_ceps_attributes: [:id, :ativo, :cep_id],
                                        logradouro_bairros_attributes: [:id, :cep_id]
                                        )
  end
end
