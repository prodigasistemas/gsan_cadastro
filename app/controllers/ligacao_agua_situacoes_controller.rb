class LigacaoAguaSituacoesController < ApplicationController
  def index
    @ligacoes_agua = LigacaoAguaSituacao.all

    render json: { entidades: @ligacoes_agua.map(&:attributes) }, status: :ok
  end
end