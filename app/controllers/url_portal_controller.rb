class UrlPortalController < ApplicationController
  def url
    url = Parametro.url_portal
    render json: { url: url }, status: :ok
  end
end