class EsferasPoderController < ApplicationController
  def index
    @esferas = EsferaPoder.all
  end
end
