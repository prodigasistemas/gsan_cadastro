class QuadraFace < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.quadra_face'
    self.primary_key = 'qdfa_id'
  
    alias_attribute "id", "qdfa_id"
    alias_attribute "indicador_existencia_rede_de_agua",    "qdfa_icredeagua"
    alias_attribute "indicador_existencia_rede_de_esgoto",  "qdfa_icredeesgoto"
    alias_attribute "distrito_operacional_id",       "diop_id"
    alias_attribute "bacia_id",       "baci_id"
    alias_attribute "ativo",          "qdfa_icuso"
    alias_attribute "numero",         "qdfa_nnfacequadra"
    alias_attribute "quadra_id",      "qdra_id"
    alias_attribute "grau_dificuldade_execucao_id",      "gdex_id"
    alias_attribute "grau_risco_seguranca_fisica_id",    "grsf_id"
    alias_attribute "condicao_abastecimento_agua_id",    "coab_id"
  
    belongs_to :distrito_operacional, foreign_key: :diop_id
    belongs_to :bacia, foreign_key: :baci_id
    
  end