class MenuController < ApplicationController
  def show

    if params[:id].present?
      @menu = MenuPresenter.new(params[:id]).constroi_arvore
      
      render json: { menu: @menu }, status: :ok
    else
      render json: { error: "Objeto não encontrado" }, status: :bad_request
    end
  end
end