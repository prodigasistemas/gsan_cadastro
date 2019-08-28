class Anormalidade < ActiveRecord::Base
    include IncrementableId
    include API::Model

    self.table_name = 'cadastro.elo_anormalidade'
    self.primary_key = 'eanm_id'

    alias_attribute "id",                    "eanm_id"
    alias_attribute "descricao",             "eanm_dseloanormalidade"
    alias_attribute "suspende_contrato_demanda", "eanm_icsuspendecontratodemanda"
    alias_attribute "indicador_uso",         "eanm_icuso"   

end
  