class RegistroAtendimento < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atendimentopublico.registro_atendimento'
  self.primary_key = 'rgat_id'

  alias_attribute 'id',                                           'rgat_id'
  alias_attribute 'tipo_especificacao_solicitacao_id',            'step_id'
  alias_attribute 'localidade_id',                                'loca_id'
  alias_attribute 'setor_comercial_id',                           'stcm_id'
  alias_attribute 'quadra_id',                                    'qdra_id'
  alias_attribute 'motivo_encerramento_atendimento_id',           'amen_id'
  alias_attribute 'meio_solicitacao_id',                          'meso_id'
  alias_attribute 'local_ocorrencia_id',                          'looc_id'
  alias_attribute 'pavimentacao_rua_id',                          'prua_id'
  alias_attribute 'pavimentacao_calcada_id',                      'pcal_id'
  alias_attribute 'motivo_reativacao_registro_atendimento_id',    'rmrv_id'
  alias_attribute 'reativacao_registro_atendimento_id',           'rgat_idreativacao'
  alias_attribute 'duplicidade_registro_atendimento_id',          'rgat_idduplicidade'
  alias_attribute 'codigo_situacao',                              'rgat_cdsituacao'
  alias_attribute 'data_hora_registro_atendimento',               'rgat_tmregistroatendimento'
  alias_attribute 'data_prevista_original',                       'rgat_dtprevistaoriginal'
  alias_attribute 'data_prevista_atual',                          'rgat_dtprevistaatual'
  alias_attribute 'quantidade_reiteracoes',                       'rgat_qtreiteracoes'
  alias_attribute 'data_hora_ultima_reiteracao',                  'rgat_tmultimareiteracao'
  alias_attribute 'descricao_observacao',                         'rgat_dsobservacao'
  alias_attribute 'descricao_local_ocorrencia',                   'rgat_dslocalocorrencia'
  alias_attribute 'ultima_alteracao',                             'rgat_tmultimaalteracao'
  alias_attribute 'descricao_parecer_encerramento',               'rgat_dsparecerencerramento'
  alias_attribute 'descricao_ponto_referencia',                   'rgat_dspontoreferencia'
  alias_attribute 'descricao_complementar_endereco',              'rgat_dscomplementondereco'
  alias_attribute 'imovel_id',                                    'imov_id'
  alias_attribute 'indicador_atendimento_online',                 'rgat_icatendimentoonline'
  alias_attribute 'bairro_area_id',                               'brar_id'
  alias_attribute 'divisao_esgoto_id',                            'dves_id'
  alias_attribute 'logradouro_bairro_id',                         'lgbr_id'
  alias_attribute 'logradouro_cep_id',                            'lgcp_id'
  alias_attribute 'data_hora_inicio_espera',                      'rgat_tminicioespera'
  alias_attribute 'data_hora_fim_espera',                         'rgat_tmfimespera'
  alias_attribute 'data_hora_ultima_emissao',                     'rgat_tmultimaemissao'
  alias_attribute 'data_hora_encerramento',                       'rgat_tmencerramento'
  alias_attribute 'codigo_setor_comercial',                       'rgat_cdsetorcomercial'
  alias_attribute 'numero_quadra',                                'rgat_nnquadra'
  alias_attribute 'numero_imovel',                                'rgat_nnimovel'
  alias_attribute 'manual_registro_atendimento_id',               'rgat_idmanual'
  alias_attribute 'unidade_atual_registro_atendimento_id',        'unid_idatual'
  alias_attribute 'coordenada_norte_ocorrencia',                  'rgat_nncoordenadanorte'
  alias_attribute 'coordenada_leste_ocorrencia',                  'rgat_nncoordenadaleste'
  alias_attribute 'indicador_execucao_liberada',                  'rgat_icexecucaoliberada'
  alias_attribute 'motivo_nao_cobranca_debito_definido',          'sncm_id'
  alias_attribute 'logradouro_inicio_perimetro_id',               'logr_idinicioperimetro'
  alias_attribute 'logradouro_final_perimetro_id',                'logr_idfimperimetro'
  alias_attribute 'face_quadra_id',                               'qdfa_id'
  alias_attribute 'indicador_coordenadas_sem_logradouro',         'rgat_iccorrdenadassemlogr'
  alias_attribute 'numero_diametro',                              'rgat_nndiametro'

  belongs_to :imovel, foreign_key: :imovel_id
  belongs_to :situacao_tipo_especificacao, foreign_key: "step_id", class_name: 'SituacaoTipoEspecificacao'
  belongs_to :motivo_encerramento, foreign_key: "amen_id", class_name: 'MotivoEncerramento'
  has_one :registro_atendimento_solicitante, foreign_key: :id, class_name: 'RegistroAtendimentoSolicitante'

  scope :ordenar_por_data_atendimento, -> { order(data_hora_registro_atendimento: :desc) }
end