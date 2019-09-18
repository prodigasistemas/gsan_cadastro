class NegativadorMovimentoReg < ActiveRecord::Base
    self.table_name  = 'cobranca.negatd_movimento_reg'
    self.primary_key = 'nmrg_id'
  
    alias_attribute "id",                      "nmrg_id"
    alias_attribute "codigoExclusaoTipo",      "nmrg_cdexclusaotipo"
    alias_attribute "regInclusao",             "nmrg_idreginclusao"
    alias_attribute "aceito",                  "nmrg_icaceito"
    alias_attribute "ngmv_id",                 "ngmv_id"
    alias_attribute "imov_id",                 "imov_id"

    belongs_to :imovel,                        foreign_key: :imov_id
    belongs_to :negativador_movimento,         foreign_key: :ngmv_id
end