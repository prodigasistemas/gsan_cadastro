class PiscinaVolumeFaixa < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.piscina_volume_faixa'
    self.primary_key = 'pisc_id'

    alias_attribute "id",                    "pisc_id"
    alias_attribute "volume_menor_faixa",    "pisc_vomenorfaixa"
    alias_attribute "volume_maior_faixa",    "pisc_vomaiorfaixa"
    alias_attribute "indicador_uso",         "pisc_icuso"   

    def medidas
        return "" if volume_menor_faixa.nil? or volume_maior_faixa.nil?

        volume_menor_faixa.to_s.concat(" A ").concat(volume_maior_faixa.to_s)
    end
end