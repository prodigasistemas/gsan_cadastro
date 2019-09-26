class SistemaEsgoto < ActiveRecord::Base
    include IncrementableId

    self.table_name  = "operacional.sistema_esgoto"
    self.primary_key = "sesg_id"

    alias_attribute "id",                        "sesg_id"
    alias_attribute "divisao_esgoto_id",         "dves_id"
    alias_attribute "descricao",                 "sesg_dssistemaesgoto"
    alias_attribute "ativo",                     "sesg_icuso"
    alias_attribute "abreviacao",                "sesg_dsabreviado"
    alias_attribute "sistema_esgoto_tratamento_tipo_id", "sett_id"

    belongs_to :divisao_esgoto, foreign_key: :dves_id
end