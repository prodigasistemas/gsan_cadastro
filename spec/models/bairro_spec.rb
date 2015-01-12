require "rails_helper"

describe Bairro do
  describe ".search_by_params" do
    let!(:bairro_1) { create municipio_id: 1 }
    let!(:bairro_2) { create municipio_id: 2 }

    it "retorna bairros de acordo a pesquisa"
  end
end
