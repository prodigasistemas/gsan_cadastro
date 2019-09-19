class NegativacaoImoveis < ActiveRecord::Base
    self.table_name  = 'cobranca.negativacao_imoveis'
    self.primary_key = 'ngim_id'
  
    alias_attribute "id",              "ngim_id"
    alias_attribute "dataExclusao",    "ngim_dtexclusao"
    alias_attribute "imov_id",         "imov_id"
    alias_attribute "ngcm_id",         "ngcm_id"

    scope :por_imovel_e_comando, -> (imovel, comando) { where("imov_id = ? and ngcm_id = ?", imovel, comando) }

    belongs_to :imovel,                foreign_key: :imov_id
    belongs_to :negativacao_comando,   foreign_key: :ngcm_id
end