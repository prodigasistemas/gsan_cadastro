class AreaConstruidaFaixa < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.area_construida_faixa'
    self.primary_key = 'acon_id'

    alias_attribute "id",                    "acon_id"
    alias_attribute "menor_faixa",           "acon_nnmenorfaixa"
    alias_attribute "maior_faixa",           "acon_nnmaiorfaixa"
    alias_attribute "indicador_uso",         "acon_icuso"   

    def medidas
        return "" if menor_faixa.nil? or maior_faixa.nil?

        menor_faixa.to_s.concat(" A ").concat(maior_faixa.to_s)
    end
end
  