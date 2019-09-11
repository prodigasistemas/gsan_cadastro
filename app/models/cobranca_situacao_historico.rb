class CobrancaSituacaoHistorico < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_situacao_hist'
  self.primary_key = 'cbsh_id'

  alias_attribute "id",                                 "cbsh_id"
  alias_attribute "ultima_alteracao",                   "cbsh_tmultimaalteracao"
  alias_attribute "data_implantacao",                   "iscb_dtimplantacaocobranca"
  alias_attribute "data_retirada",                      "iscb_dtretiradacobranca"
  alias_attribute "data_exclusao",                      "venc_dtexclusao"
  alias_attribute "ano_mes_situacao_cobranca_inicio",   "cbsh_amcobrancasituacaoinicio"
  alias_attribute "ano_mes_situacao_cobranca_final",    "cbsh_amcobrancasituacaofim"
  alias_attribute "ano_mes_cobranca_retirada",          "cbsh_amcobrancaretirada"
  alias_attribute "observacao_inclusao",                "cbsh_dsobservacaoinforma"
  alias_attribute "observacao_retirada",                "cbsh_dsobservacaoretira"
  alias_attribute "data_fim_situacao",                  "cbsh_dsobservacaoretira"
  alias_attribute "imov_id",                            "imov_id"
  alias_attribute "usuario_id",                         "usur_id"
  alias_attribute "usur_idinforma",                     "usur_idinforma"
  alias_attribute "usur_idretira",                      "usur_idretira"
  alias_attribute "cbsc_idinforma",                     "cbsc_idinforma"
  alias_attribute "cbsc_idretirada",                    "cbsc_idretirada"
  alias_attribute "cbsm_id",                            "cbsm_id"
  alias_attribute "cbsp_id",                            "cbsp_id"
  
  belongs_to  :usuario_informante,        foreign_key: :usur_idinforma,   class_name: 'Usuario'
  belongs_to  :usuario_retirante,         foreign_key: :usur_idretira,    class_name: 'Usuario'
  belongs_to  :usuario,                   foreign_key: :usuario_id,       class_name: 'Usuario'
  belongs_to  :cobranca_situacao_motivo,  foreign_key: :cbsm_id,          class_name: 'CobrancaSituacaoMotivo'
  belongs_to  :cobranca_situacao_tipo,    foreign_key: :cbsp_id,          class_name: 'CobrancaSituacao'
  belongs_to  :comando_inclusao,          foreign_key: :cbsc_idinforma,   class_name: 'CobrancaSituacao'
  belongs_to  :comando_retirada,          foreign_key: :cbsc_idretirada,  class_name: 'CobrancaSituacao'

  delegate :usuario_informante,       to: :imovel, allow_nil: true, prefix: true
  delegate :usuario_retirante,        to: :imovel, allow_nil: true, prefix: true
  delegate :usuario,                  to: :imovel, allow_nil: true, prefix: true
  delegate :cobranca_situacao_motivo, to: :imovel, allow_nil: true, prefix: true
  delegate :cobranca_situacao_tipo,   to: :imovel, allow_nil: true, prefix: true
  delegate :comando_inclusao,         to: :imovel, allow_nil: true, prefix: true
  delegate :comando_retirada,         to: :imovel, allow_nil: true, prefix: true
end