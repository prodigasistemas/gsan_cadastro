class SituacaoAtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.situacao_atlz_cadastral'
  self.primary_key = 'siac_id'

  alias_attribute "id", "siac_id"
  alias_attribute "descricao", "siac_dssituacao"
  alias_attribute "indicador_uso", "siac_icuso"
  alias_attribute "ultima_alteracao", "siac_tmultimaalteracao"

  has_many :imovel_controle_atualizacao_cadastral, foreign_key: "siac_id"
  has_many :imovel_retornos, through: :imovel_controle_atualizacao_cadastral, foreign_key: "imre_id"

  SITUACOES = {"DISPONIVEL": 0,
    "BLOQUEADO": 1,
    "EM CAMPO": 2,
    "TRANSMITIDO": 3,
    "APROVADO": 4,
    "EM FISCALIZACAO": 5,
    "ATUALIZADO": 6,
    "PRE APROVADO": 7,
    "EM REVISAO": 8,
    "REVISADO": 9,
    "A REVISAR": 10,
    "REVISITA": 11 }

  GSAN_SITUACOES = [0, 1, 2, 4, 5, 6, 10]
end
