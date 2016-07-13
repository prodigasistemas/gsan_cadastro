class EmpresasController < ApplicationController
  def index
    @total    = Empresa.count
    @empresas = Empresa.all
  end
end