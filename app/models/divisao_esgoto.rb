class DivisaoEsgoto < ActiveRecord::Base
    include IncrementableId

    self.table_name  = "operacional.divisao_esgoto"
    self.primary_key = "dves_id"

    alias_attribute "id",                        "dves_id"
    alias_attribute "divisao_esgoto_id",         "dves_id"
    alias_attribute "descricao",                 "dves_dsdivisaoesgoto"
    alias_attribute "ativo",                     "dves_icuso"
    alias_attribute "unidade_id",                "unid_id"
end