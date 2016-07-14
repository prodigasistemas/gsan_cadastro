require 'digest/sha1'

class Usuario <ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'seguranca.usuario'
  self.primary_key = 'usur_id'

  alias_attribute "id",              "usur_id"
  alias_attribute "login",           "usur_nmlogin"
  alias_attribute "senha",           "usur_nmsenha"
  alias_attribute "nome",            "usur_nmusuario"

  def self.login(login, senha)
    sha1 = Digest::SHA1.base64digest senha

    return Usuario.find_by(login: login, senha: sha1)
  end

  def attributes
    {
      id: id,
      nome_usuario: login,
      nome: nome
    }
  end
end