class VencimentoAlternativo < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model

    self.table_name  = 'faturamento.vencimento_alternativo'
    self.primary_key = 'venc_id'

    alias_attribute "id", "venc_id"
    alias_attribute "ultima_alteracao", "venc_tmultimaalteracao"
    alias_attribute "data_implantacao", "venc_dtimplantacao"
    alias_attribute "data_vencimento", "venc_ddvencimento"
    alias_attribute "data_exclusao", "venc_dtexclusao"
    alias_attribute "imovel", "imov_id"

    belongs_to :imovel, foreign_key: 'imov_id'
end