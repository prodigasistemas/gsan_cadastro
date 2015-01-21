class DistritoOperacionaisController < ApplicationController
  def index
    @distrito_operacionais = DistritoOperacional.all
  end
end
