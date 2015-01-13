class MicroRegioesController < ApplicationController
  def index
    @micro_regioes = MicroRegiao.all
  end
end
