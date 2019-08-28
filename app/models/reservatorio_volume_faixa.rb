class ReservatorioVolumeFaixa < ActiveRecord::Base
    include IncrementableId
    include API::Model
    include API::Filterable

    self.table_name = 'cadastro.reservatorio_volume_fx'
    self.primary_key = 'resv_id'

    alias_attribute "id",                    "resv_id"
    alias_attribute "volume_menor_faixa",    "resv_vomenorfaixa"
    alias_attribute "volume_maior_faixa",    "resv_vomaiorfaixa"
    alias_attribute "indicador_uso",         "resv_icuso"   

    def medidas
        return "" if volume_menor_faixa.nil? or volume_maior_faixa.nil?

        volume_menor_faixa.to_s.concat(" A ").concat(volume_maior_faixa.to_s)
    end
end