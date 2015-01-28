class UnidadeFederacoesController < ApplicationController
  def index
    @unidade_federacoes = UnidadeFederacao.all
    if params[:query].present?
      query = params[:query].deep_symbolize_keys
      @unidade_federacoes = UnidadeFederacao.filter(query)
      @total = @unidade_federacoes.count
      @unidade_federacoes = @unidade_federacoes.page(params[:page]).per(20)
    else
      @unidade_federacoes = UnidadeFederacao.order(descricao: :asc)
    end
  end

  def show
    @unidade_federacao = UnidadeFederacao.find params[:id]
  end

  def create
    @unidade_federacao = UnidadeFederacao.new unidade_federacao_params

    if @unidade_federacao.save
      render :show
    else
      render_erros
    end
  end

  def update
    @unidade_federacao = UnidadeFederacao.find params[:id]

    if @unidade_federacao.update unidade_federacao_params
      render :show
    else
      render_erros
    end
  end

  private
  def unidade_federacao_params
    params.require(:unidade_federacao).permit(:descricao, :sigla)
  end

  def render_erros
    render json: { errors: @unidade_federacao.errors.full_messages }, status: 422
  end
end
