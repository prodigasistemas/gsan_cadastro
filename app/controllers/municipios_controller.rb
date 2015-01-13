class MunicipiosController < ApplicationController
  def index
    @municipios = Municipio.all
  end

  def create
    @municipio = Municipio.new(municipio_params)

    if @municipio.save
      render :show
    else
      render json: { errors: @municipio.errors.full_messages }, status: 422
    end
  end

  private

  def municipio_params
    params.require(:municipio).permit :nome,
                                      :codigo_ibge,
                                      :quadro_bairro,
                                      :inicio_concessao, :fim_concessao,
                                      :cep_inicial, :cep_final,
                                      :ddd,
                                      :regiao_desenvolvimento_id,
                                      :micro_regiao_id,
                                      :uf_id,
                                      :ativo

  end
end
