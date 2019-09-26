class CobrancaDocumento < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cobranca.cobranca_documento'
    self.primary_key = 'cbdo_id'
  
    alias_attribute "id",                          "cbdo_id"
    alias_attribute "numero_sequencia_documento", "cbdo_nnsequenciadocumento"
    alias_attribute "emissao",                    "cbdo_tmemissao"
    alias_attribute "valor_desconto",             "cbdo_vldesconto"
    alias_attribute "valor_documento",            "cbdo_vldocumento"
    alias_attribute "valor_taxa",                 "cbdo_vltaxa"
    alias_attribute "valor_acrescimos",           "cbdo_vlacrescimos"
    alias_attribute "data_situacao_acao",         "cbdo_dtsituacaoacao"
    alias_attribute "data_situacao_debito",       "cbdo_dtsituacaodebito"

    alias_attribute "cbac_id",                  "cbac_id"
    alias_attribute "demf_id",                  "demf_id"
    alias_attribute "dotp_id",                  "dotp_id"
    alias_attribute "imov_id",                  "imov_id"
    alias_attribute "caac_id",                  "caac_id"
    alias_attribute "orse_id",                  "orse_id"

    belongs_to :cobranca_acao,                      foreign_key: "cbac_id"
    belongs_to :documento_emissao_forma,            foreign_key: "demf_id"
    belongs_to :documento_tipo,                     foreign_key: "dotp_id"
    belongs_to :imovel,                             foreign_key: "imov_id"
    belongs_to :cobranca_acao_atividade_cronograma, foreign_key: "caac_id"
    belongs_to :cobranca_acao_atividade_comando,    foreign_key: "cacm_id"

    has_many :cobranca_documento_itens,             foreign_key: :cbdo_id, class_name: "CobrancaDocumentoItem"
    has_many :ordens_servico,                       foreign_key: :cbdo_id, class_name: "OrdemServico"
end