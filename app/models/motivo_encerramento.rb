class MotivoEncerramento < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atendimentopublico.atend_motivo_encmt'
  self.primary_key = 'amen_id'

  alias_attribute 'id',                       'amen_id'
  alias_attribute 'descricao',                'amen_dsmotivoencerramento'
  alias_attribute 'descricao_abreviada',      'amen_dsabreviado'
  alias_attribute 'indicador_uso',            'amen_icuso'
  alias_attribute 'ultima_alteracao',         'amen_tmultimaalteracao'
  alias_attribute 'indicador_execucao',       'amen_icexecucao'
  alias_attribute 'indicador_duplicidade',    'amen_icduplicidade'
  alias_attribute 'quantidade_dias_ativo',    'amen_qtdiasaditivoprazo'
  alias_attribute 'exibe_no_formulario',      'amen_icexibiformordemseletiva'
  alias_attribute 'indicador_fiscalizacao',   'amen_icfiscalizacao'

  belongs_to :registro_atendimento, foreign_key: :id, class_name: 'RegistroAtendimento'
end