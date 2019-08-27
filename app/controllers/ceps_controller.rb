class CepsController < ApplicationController
  def index
    query = params[:query]
    @ceps = Cep.com_dados.filtrar_campos(query)
    @total = @ceps.count
    @ceps = @ceps.page(params[:page]).per(20)
  end

  def show
    @cep = Cep.find(params[:id])
  end

  def create
    @municipio = Municipio.find_by(id: params[:cep][:muni_id])
    create_cep_params = @municipio ? {}.merge(cep_params).merge(municipio: @municipio.nome, uf: @municipio.uf.sigla) : cep_params
    @cep = Cep.new(create_cep_params)
    @cep.municipio_model = @municipio

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
    create_cep_params = @municipio ? cep_params.merge(municipio: @municipio.nome, uf: @municipio.uf.sigla) : cep_params
    @cep.municipio_model = @municipio

    if @cep.update_attributes(create_cep_params)
      render :show
    else
      render json: { errors: @cep.errors.full_messages }, status: 422
    end
  end

  def search
    query = params[:query]
    @cep = Cep.find_by codigo: query[:codigo]
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
                                :logradouro_tipo,
                                :uf)
  end
end
