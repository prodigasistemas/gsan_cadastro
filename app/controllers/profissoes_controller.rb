class ProfissoesController < ApplicationController
  def index
    @profissoes = Profissao.all
  end
end
