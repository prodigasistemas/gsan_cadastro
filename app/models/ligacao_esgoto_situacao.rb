class LigacaoEsgotoSituacao < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atendimentopublico.ligacao_esgoto_situacao'
  self.primary_key = 'lest_id'

  alias_attribute "id", "lest_id"
  alias_attribute "descricao", "lest_dsligacaoesgotosituacao"
  alias_attribute "indicador_uso", "lest_icuso"
  alias_attribute "ultima_alteracao", "lest_tmultimaalteracao"
  alias_attribute "abreviado", "lest_dsabreviado"
  alias_attribute "indicador_faturamento", "lest_icfaturamento"
  alias_attribute "volume_minimo", "lest_nnvolumeminimo"
  alias_attribute "indicador_existencia_rede", "lest_icexistenciarede"
  alias_attribute "indicador_existencia_ligacao", "lest_icexistencialigacao"
  alias_attribute "indicador_cadastrada_esgoto", "lest_iccadastradaesgoto"
  alias_attribute "indicador_ativo_esgoto", "lest_icativaesgoto"
  alias_attribute "indicador_desligada_esgoto", "lest_icdesligadaesgoto"
  alias_attribute "indicador_analise_esgoto", "lest_icanaliseesgoto"
end