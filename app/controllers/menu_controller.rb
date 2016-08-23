class MenuController < ApplicationController
  def show

    if params[:id]
      @menu = MenuPresenter.new(params[:id]).constroi_arvore
      
      render json: { menu: @menu }, status: :ok
    end
  end
end