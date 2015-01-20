class OrgaosExpedidoresRgController < ApplicationController
  def index
    @orgaos = OrgaoExpedidorRg.all
  end
end
