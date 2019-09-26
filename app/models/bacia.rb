class Bacia < ActiveRecord::Base
    include IncrementableId

    self.table_name  = "operacional.bacia"
    self.primary_key = "baci_id"

    alias_attribute "id",                        "baci_id"
    alias_attribute "sistema_esgoto_id",         "sesg_id"
    alias_attribute "descricao",                 "baci_dsbacia"
    alias_attribute "ativo",                     "baci_icuso"

    belongs_to :sistema_esgoto, foreign_key: :sesg_id
end