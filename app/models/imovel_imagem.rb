class ImovelImagem < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.imovel_imagem'
    self.primary_key = 'imim_id'
  
    alias_attribute "id", "imim_id"
    alias_attribute "nome_imagem", "imim_nmimagem"
    alias_attribute "caminho_imagem", "imim_caminhoimagem"
    alias_attribute "ultima_alteracao", "imim_tmultimaalteracao"
    alias_attribute "imovel", "imov_id"

    belongs_to :imovel, foreign_key: 'imov_id'
  end