class ImagemRetorno < ActiveRecord::Base
  include IncrementableId
  include API::Filterable
  include API::Model

  self.table_name  = 'atualizacaocadastral.imagem_retorno'
  self.primary_key = :imgr_id



  alias_attribute :id,                :imgr_id
  alias_attribute :imovel_retorno_id, :imre_id
  alias_attribute :imovel_id,         :imov_id
  alias_attribute :nome_imagem,       :imgr_nomeimagem
  alias_attribute :caminho_imagem,    :imgr_pathimagem
  alias_attribute :ultima_alteracao,  :imgr_tmultimaalteracao

  scope :por_imovel, ->(imovel_id) { where('imov_id = ? or imre_id = ?', imovel_id, imovel_id).order(ultima_alteracao: :desc) }
end
