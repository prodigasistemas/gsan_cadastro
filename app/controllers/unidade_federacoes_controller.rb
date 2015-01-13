class UnidadeFederacoesController < ApplicationController
  def index
    @unidade_federacoes = UnidadeFederacao.all
  end
end
