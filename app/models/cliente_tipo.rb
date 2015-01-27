class ClienteTipo < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.cliente_tipo'
  self.primary_key = 'cltp_id'

  alias_attribute "id",                     "cltp_id"                     # integer NOT NULL, -- id do tipo do cliente
  alias_attribute "descricao",              "cltp_dsclientetipo"          # character varying(50), -- descricao do tipo de cliente
  alias_attribute "pessoa_fisica_juridica", "cltp_icpessoafisicajuridica" # smallint, -- indicador de pessoa fisica ou juridica
  alias_attribute "ativo",                  "cltp_icuso"                  # smallint, -- indicador de uso
  alias_attribute "atualizado_em",          "cltp_tmultimaalteracao"      # timestamp without time zone NOT NULL DEFAULT now(), -- timestamp inclusa/ultima alteracao
  alias_attribute "esfera_poder_id",        "epod_id"                     # integer, -- id da esfera de poder

  belongs_to :esfera_poder, foreign_key: "epod_id"

  scope :descricao,              -> (descricao)       { where("UPPER(cltp_dsclientetipo) LIKE ?", "%#{descricao.upcase}%") }
  scope :pessoa_fisica_juridica, -> (tipo_id)         { where(pessoa_fisica_juridica: tipo_id) }
  scope :esfera_poder_id,        -> (esfera_poder_id) { where(esfera_poder_id: esfera_poder_id) }

  def pessoa_tipo
    if pessoa_fisica_juridica == 1
      "Pessoa Física"
    elsif pessoa_fisica_juridica == 2
      "Pessoa Jurídica"
    end
  end
end
