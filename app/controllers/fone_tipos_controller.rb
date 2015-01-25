class FoneTiposController < ApplicationController
  def index
    @tipos = FoneTipo.all
  end
end
