class AcoesController < ApplicationController
  before_action :find_acao, only: [:show, :update, :destroy]

  def index
    @total = Acao.count
    @acoes = Acao.includes(:contrato_medicao).all

    if @acoes.any?
      render json: { entidades: @acoes.map(&:atributos), total: @total }, status: :ok
    else
      render json: { entidades: [], total: @total }, status: :ok
    end
  end

  def show
    @acao = Acao.find params[:id]

    if @acao
      render json: { entidade: @acao.atributos }, status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def create
    @acao = Acao.new(acao_params)

    if @acao.save
      render json: { entidade: @acao.atributos }, status: :ok
    else
      render json: { errors: @acao.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @acao.update acao_params
      render json: { entidade: @acao.atributos }, status: :ok
    else
      render json: { errors: @acao.errors }, status: :unprocessable_entity
    end
  end

  private

  def find_acao
    @acao = Acao.find(params[:id])
  end

  def acao_params
    params.require(:acao)
      .permit(:titulo,
              :descricao,
              :contrato_medicao_id)

  end
end