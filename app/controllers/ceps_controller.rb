class CepsController < ApplicationController
  def index
    query = params[:query].deep_symbolize_keys
    query[:logradouro] = nil
    query[:bairro] = nil
    query[:municipio] = nil

    @ceps = Cep.where(query.reject! { |k,v| v.blank? })
    @ceps = @ceps.where("UPPER(cep_nmlogradouro) LIKE ?", "%#{params[:query][:logradouro].upcase}%") if params[:query][:logradouro]
    @ceps = @ceps.where("UPPER(cep_nmbairro) LIKE ?", "%#{params[:query][:bairro].upcase}%") if params[:query][:bairro]
    @ceps = @ceps.where("UPPER(cep_nmmunicipio) LIKE ?", "%#{params[:query][:municipio].upcase}%") if params[:query][:municipio]

    @total = @ceps.count
    @ceps = @ceps.page(params[:page]).per(20)
  end

  def show
    @cep = Cep.find(params[:id])
  end

  def create
    @municipio = Municipio.find_by(id: params[:cep][:muni_id])
    create_cep_params = @municipio ? cep_params.merge(municipio: @municipio.nome, uf: @municipio.uf.sigla) : cep_params
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
    create_cep_params = @municipio ? cep_params.merge(municipio: @municipio.nome, uf: @municipio.uf.sigla) : cep_params

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
