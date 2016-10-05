class RelatoriosController < ApplicationController
  def create
    path = RelatorioService.new(params).gerar

    if not path.nil?
      render json: {url: "http://#{request.host_with_port}/#{path}"}, status: 200
    else
      render json: {error: "Não foram encontradas informações para a geração do relatório"}, status: 422
    end
  end
end
