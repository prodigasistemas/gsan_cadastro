class AtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Model

  self.table_name  = 'seguranca.tab_atlz_cadastral'
  self.primary_key = 'tatc_id'

  alias_attribute :tabela_id,                  :tabe_id
  alias_attribute :leiturista_id,              :leit_id
  alias_attribute :arquivo_texto_atlz_cad_id,  :txac_id
  alias_attribute :codigo_imovel,              :tatc_cdimovel
  alias_attribute :codigo_cliente,             :tatc_cdcliente
end