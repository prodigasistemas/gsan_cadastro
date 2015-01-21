class PessoaSexosController < ApplicationController
  def index
    @sexos = PessoaSexo.all
  end
end
