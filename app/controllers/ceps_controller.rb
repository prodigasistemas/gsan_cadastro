class CepsController < ApplicationController
  def index
    @ceps = Cep.last(100)
  end

  def show
    @cep = Cep.find(params[:id])
  end

  def create
    @municipio = Municipio.find_by(id: params[:cep][:muni_id])
    create_cep_params = @municipio ? cep_params.merge(municipio: @municipio.nome) : cep_params
    @cep = Cep.new(create_cep_params)

    if @cep.save
      render :show
    else
      render json: { errors: @cep.errors.full_messages }, status: 422
    end
  end

  def edit
    @cep = Cep.find params[:id]
    municipiosPesquisa = Municipio.where(nome: @cep.municipio)
    @bairros = Bairro.pesquisar(municipio_id: municipiosPesquisa)
  end

  def update
    @cep = Cep.find params[:id]
    @municipio = Municipio.find_by(id: params[:cep][:muni_id])
    create_cep_params = @municipio ? cep_params.merge(municipio: @municipio.nome) : cep_params

    if @cep.update_attributes(create_cep_params)
      render :show
    else
      render json: { errors: @cep.errors.full_messages }, status: 422
    end
  end

  private

  def cep_params
    params.require(:cep).permit(:ativo,
                                :bairro,
                                :codigo,
                                :intervalo,
                                :logradouro,
                                :municipio,
                                :tipo_id,
                                :tipo_logradouro,
                                :uf)
  end
end
