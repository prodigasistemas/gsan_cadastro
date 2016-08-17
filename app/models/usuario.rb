require 'digest/sha1'

class Usuario < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'seguranca.usuario'
  self.primary_key = 'usur_id'

  alias_attribute :id,           :usur_id
  alias_attribute :nome_usuario, :usur_nmlogin
  alias_attribute :senha,        :usur_nmsenha
  alias_attribute :nome,         :usur_nmusuario
  alias_attribute :empresa_id,   :empr_id

  belongs_to :empresa, foreign_key: :empr_id

  has_many :leituristas, foreign_key: "usur_id"
  has_many :empresas, through: :leituristas, foreign_key: "empr_id"

  def self.login(login, senha)
    sha1 = Digest::SHA1.base64digest senha

    return Usuario.find_by(nome_usuario: login, senha: sha1)
  end
end