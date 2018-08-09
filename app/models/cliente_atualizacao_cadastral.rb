class ClienteAtualizacaoCadastral < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model


  self.table_name  = 'cadastro.cliente_atlz_cadastral'
  self.primary_key = 'clac_id'

  alias_attribute :id,                                     :clac_id
  alias_attribute :cliente_id,                             :clie_id
  alias_attribute :imovel_id,                              :imov_id
  alias_attribute :nome,                                   :clac_nmcliente
  alias_attribute :cliente_tipo_id,                        :cltp_id
  alias_attribute :rg,                                     :clac_nnrg
  alias_attribute :data_emissao_rg,                        :clac_dtrgemissao
  alias_attribute :data_nascimento,                        :clac_dtnascimento
  alias_attribute :profissao_id,                           :prof_id
  alias_attribute :pessoa_sexo_id,                         :psex_id
  alias_attribute :cpf,                                    :clac_nncpfcnpj
  alias_attribute :email,                                  :clac_dsemail
  alias_attribute :indicador_uso,                          :clac_icuso
  alias_attribute :ultima_alteracao,                       :clac_tmultimaalteracao
  alias_attribute :nome_mae,                               :clac_nnmae
  alias_attribute :endereco_tipo_id,                       :edtp_id
  alias_attribute :logradouro_id,                          :logr_id
  alias_attribute :descricao_logradouro,                   :clac_dslogradouro
  alias_attribute :codigo_cep,                             :clac_cdcep
  alias_attribute :bairro_id,                              :bair_id
  alias_attribute :nome_bairro,                            :clac_nmbairro
  alias_attribute :endereco_referencia_id,                 :edrf_id
  alias_attribute :numero_imovel,                          :clac_nnimovel
  alias_attribute :complemento_endereco,                   :clac_dscomplementoendereco
  alias_attribute :cnae,                                   :clac_nncnae
  alias_attribute :cliente_relacaoTipo_id,                 :crtp_id
  alias_attribute :descricao_logradouro_titulo,            :clac_dslogradourotitulo
  alias_attribute :descricao_logradouro_tipo,              :clac_dslogradourotipo
  alias_attribute :logradouro_titulo_id,                   :lgtt_id
  alias_attribute :logradouro_tipo_id,                     :lgtp_id
  alias_attribute :municipio_id,                           :muni_id
  alias_attribute :nome_municipio,                         :clac_nmmunicipio
  alias_attribute :uinidade_federacao_id,                  :unfe_id
  alias_attribute :descricao_uf_sigla_municipio,           :clac_dsufsiglamunicipio
  alias_attribute :descricao_abreviada_orgao_expedidor_rg, :clac_dsabreviadaoerg
  alias_attribute :descricao_uf_sigla_orgao_expedidor_rg,  :clac_dsufsiglaoerg
  alias_attribute :ramo_atividade_id,                      :ratv_id
end
