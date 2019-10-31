class RegistroAtendimentoSolicitante < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atendimentopublico.ra_solicitante'
  self.primary_key = 'raso_id'

  alias_attribute 'id',                                         'raso_id'
  alias_attribute 'registro_atendimento_id',                    'rgat_id'
  alias_attribute 'cliente_id',                                 'clie_id'
  alias_attribute 'numero_imovel',                              'raso_nnimovel'
  alias_attribute 'descricao_ponto_referencia',                 'raso_dspontoreferencia'
  alias_attribute 'descricao_complementar_endereco',            'raso_dscomplementondereco'
  alias_attribute 'nome_solicitante',                           'raso_nmsolicitante'
  alias_attribute 'indicador_solicitante_principal',            'raso_icsolicitanteprincipal'
  alias_attribute 'ultima_alteracao',                           'raso_tmultimaalteracao'
  alias_attribute 'unidade_id',                                 'unid_id'
  alias_attribute 'funcionario_id',                             'func_id'
  alias_attribute 'logradouro_bairro_id',                       'lgbr_id'
  alias_attribute 'logradouro_cep_id',                          'lgcp_id'
  alias_attribute 'logradouro_inicio_perimetro_id',             'logr_idinicioperimetro'
  alias_attribute 'logradouro_final_perimetro_id',              'logr_idfimperimetro'
  alias_attribute 'numero_protocolo',                           'raso_nnprotocoloatendimento'
  alias_attribute 'indicador_envio_email_pesquisa_satisfacao',  'raso_icenvioemailpesquisa'
  alias_attribute 'email_solicitante',                          'raso_dsemail'

  belongs_to :registro_atendimento, foreign_key: 'rgat_id', class_name: 'RegistroAtendimento'
end
