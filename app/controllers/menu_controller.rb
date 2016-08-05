class MenuController < ApplicationController
  def show

    if params[:id]
      @root = Menu.new(params[:id])
      
      @root.constroi_arvore

      render json: { menu: @root }, status: :ok
    end
  end
end