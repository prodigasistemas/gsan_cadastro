class CobrancaSituacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cobranca.cobranca_situacao'
  self.primary_key = 'cbst_id'

  alias_attribute "id", "cbst_id"
  alias_attribute "descricao", "cbst_dscobrancasituacao"
  alias_attribute "indicador_uso", "cbst_icuso"
  alias_attribute "ultima_alteracao", "cbst_icexigenciaadvogado"
  alias_attribute "bloqueio_inclusao", "cbst_icbloqueioinclusao"
  alias_attribute "bloqueio_parcelamento", "cbst_icbloqueioparcel"
  alias_attribute "bloqueio_retirada", "cbst_icbloqueioretirada"
  alias_attribute "indicador_selecao_permissao_especial", "cbst_icselecaopermesp"
  alias_attribute "indicador_situacao_cobranca", "cbst_icprescreveparticular"
  alias_attribute "codigo_constante", "cbst_cdconstante"
  alias_attribute "indicador_motivo", "cbst_icnaocobranca"
  alias_attribute "identificao_cancelar", "cbst_iccancelanegativacao"
  alias_attribute "profissao", "prof_id"
  alias_attribute "ramo_atividade", "ratv_id"
  alias_attribute "conta_motivo_revisao", "cmrv_id"
  
  belongs_to :profissao,       foreign_key: "prof_id"
  belongs_to :ramo_atividade,       foreign_key: "ratv_id"
end