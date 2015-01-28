class EsferaPoder < ActiveRecord::Base
  include IncrementableId
  include Filterable

  self.table_name  = 'cadastro.esfera_poder'
  self.primary_key = 'epod_id'

  alias_attribute "id",                                      "epod_id"                      # integer NOT NULL, -- id da esfera de poder
  alias_attribute "descricao",                               "epod_dsesferapoder"           # character varying(30), -- descricao da esfera de poder
  alias_attribute "ativo",                                   "epod_icuso"                   # smallint, -- indicador de uso (1-ativo 2-inativo)
  alias_attribute "atualizado_em",                           "epod_tmultimaalteracao"       # timestamp without time zone NOT NULL DEFAULT now(), -- timestamp inclusao/ultima alteracao
  alias_attribute "permite_gerar_certidao_negativa_imovel",  "epod_icpermitecndparaimovel"  # smallint NOT NULL DEFAULT 2, -- Indicador se a esfera de poder permite a geracao  de certidao negativa para imovel (1-SIM, 2-NAO)
  alias_attribute "permite_gerar_certidao_negativa_cliente", "epod_icpermitecndparacliente" # smallint NOT NULL DEFAULT 2, -- Indicador se a esfera de poder permite a geracao  de certidao negativa para cliente (1-SIM, 2-NAO)


  scope :descricao,                               -> (descricao)  { where("UPPER(epod_dsesferapoder) LIKE ?", "%#{descricao.upcase}%") }
  scope :permite_gerar_certidao_negativa_imovel,  -> (i)          { where permite_gerar_certidao_negativa_imovel:   i }
  scope :permite_gerar_certidao_negativa_cliente, -> (i)          { where permite_gerar_certidao_negativa_cliente:  i }
end
