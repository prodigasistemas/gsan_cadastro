class Categoria < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'cadastro.categoria'
  self.primary_key = 'catg_id'

  alias_attribute "id", "catg_id"
  alias_attribute "descricao", "catg_dscategoria"
  alias_attribute "descricao_abreviada", "catg_dsabreviado"
  alias_attribute "consumo_minimo", "catg_nnconsumominimo"
  alias_attribute "consumo_estouro", "catg_nnconsumoestouro"
  alias_attribute "vezes_media_estouro", "catg_nnvezesmediaestouro"
  alias_attribute "media_baixo_consumo", "catg_nnmediabaixoconsumo"
  alias_attribute "porcentagem_media_baixo_consumo", "catg_pcmediabaixoconsumo"
  alias_attribute "consumo_alto", "catg_nnconsumoalto"
  alias_attribute "vezes_media_alto_consumo", "catg_nnvezesmediaaltoconsumo"
  alias_attribute "indicador_uso", "catg_icuso"
  alias_attribute "ultima_alteracao", "catg_tmultimaalteracao"
  alias_attribute "numero_consumo_maximo_ec", "catg_nnconsumomaximoec"
  alias_attribute "indicador_cobranca_acrescimos", "catg_iccobrancaacrescimos"
  alias_attribute "consumo_maximo_economias_validacao", "catg_nnmaxeconomiasvalidacao"
  alias_attribute "fator_economias", "catg_nnfatoreconomias"
  alias_attribute "indicador_permissao_especial", "catg_icpermissaoespecial"

  has_many :subcategorias, foreign_key: :catg_id
end
