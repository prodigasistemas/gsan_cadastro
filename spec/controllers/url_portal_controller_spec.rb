require 'rails_helper'

describe UrlPortalController, type: :controller do
  let!(:parametro) { create(:parametro) }
  
  describe "GET url" do
    it "retorna a url do portal" do
      get :url
      expect(json['url']).to eq 'http://portalgsan.cosanpa.pa.gov.br'
    end
  end

end