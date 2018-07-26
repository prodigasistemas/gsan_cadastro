class Leiturista < ActiveRecord::Base
  include IncrementableId
  include API::Model
  include API::Filterable

  self.table_name = 'micromedicao.leiturista'
  self.primary_key = 'leit_id'

  alias_attribute "id", "leit_id"
  alias_attribute "funcionario_id", "func_id"
  alias_attribute "cliente_id", "clie_id"
  alias_attribute "codigo_ddd", "leit_cdddd"
  alias_attribute "numero_telefone", "leit_nnfone"
  alias_attribute "indicador_uso", "leit_icuso"
  alias_attribute "ultima_alteracao", "leit_tmultimaalteracao"
  alias_attribute "empresa_id", "empr_id"
  alias_attribute "numero_celular", "leit_nnimei"
  alias_attribute "usuario_id", "usur_id"
  alias_attribute "versao_mobile_id", "vemo_id"
  alias_attribute "indicador_leiturista_agente_comercial", "leit_icagencomercial"
  alias_attribute "unidade_comercial_id", "unid_id"

  belongs_to :usuario,     foreign_key: "usur_id"
  belongs_to :empresa,     foreign_key: "empr_id"
  belongs_to :funcionario, foreign_key: "func_id"

  has_many :arquivo_texto_atlz_cads, foreign_key: :leit_id
  has_many :imovel_retornos, through: :arquivo_texto_atlz_cads, foreign_key: :rota_id

  scope :nomes, -> { joins(:funcionario).where('funcionario.func_nmfuncionario is not null') }

  def nome
    joins(:funcionario).select(:func_nmfuncionario)
  end
end
