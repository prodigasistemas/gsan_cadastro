class DebitoTipo < ActiveRecord::Base
  self.table_name  = 'faturamento.debito_tipo'
  self.primary_key = 'dbtp_id'

  alias_attribute "id",                             "dbtp_id"
  alias_attribute "descricao",                      "dbtp_dsdebitotipo"
  alias_attribute "descricao_abreviada",            "dbtp_dsabreviado"
  alias_attribute "indicador_uso",                  "dbtp_icuso"
  alias_attribute "ultima_alteracao",               "dbtp_tmultimaalteracao"
  alias_attribute "valor_limite",                   "dbtp_vllimite"
  alias_attribute "valor_sugerido",                 "dbtp_vlsugerido"
  alias_attribute "indicador_geracao_automatica",   "dbtp_icgeracaoautomatica"
  alias_attribute "indicador_geracao_conta",        "dbtp_icgeracaoconta"
  alias_attribute "valor_limite_inferior",          "dbtp_valorlimiteinferior"
  alias_attribute "codigo_constante",               "dbtp_nncodigoconstante"
  alias_attribute "indicador_debito_cartao_credito","dbtp_iccartaocredito"
  alias_attribute "indicador_juros_par_cliente",    "dbtp_icguiajurosctrparcel"
  
  belongs_to :imovel, foreign_key:  :imov_id
end