class LigacaoAgua < ActiveRecord::Base
    include IncrementableId
    include API::Model
  
    self.table_name = 'atendimentopublico.ligacao_agua'
    self.primary_key = 'lagu_id'
  
    alias_attribute "id", "lagu_id"
    alias_attribute "data_implantacao", "lagu_dtimplantacao"
    alias_attribute "data_ligacao",      "lagu_dtligacaoagua"
    alias_attribute "data_supressao",   "lagu_dtsupressaoagua"
    alias_attribute "data_corte", "lagu_dtcorte" 
    alias_attribute "data_religacao", "lagu_dtreligacaoagua"
    alias_attribute "numero_seloCorte", "lagu_nnselocorte"
    alias_attribute "numero_selo_supressao", "lagu_nnselosupressao"
    alias_attribute "ultima_alteracao", "lagu_tmultimaalteracao" 
    alias_attribute "numero_consumo_minimo_agua", "lagu_nnconsumominimoagua" 
    alias_attribute "laguIcemissaocortesupressao", "lagu_icemissaocortesupressao" 
    alias_attribute "data_corte_administrativo", "lagu_dtcorteadministrativo" 
    alias_attribute "data_restabelecimento_agua", "lagu_dtrestabelecimentoagua" 
    alias_attribute "numero_lacre", "lagu_nnlacre" 
    alias_attribute "profundidade_ramal", "lagu_profundidade_ramal" 
    alias_attribute "distancia_instalacao_ramal", "lagu_dist_inst_ramal"   
  
    has_one :imovel, foreign_key: :imov_id, class_name: 'Imovel'

    belongs_to :ligacao_agua_diametro, foreign_key: :lagd_id, class_name: "LigacaoAguaDiametro"
    belongs_to :ligacao_agua_material, foreign_key: :lagm_id, class_name: "LigacaoAguaMaterial"
    belongs_to :ligacao_agua_perfil, foreign_key: :lapf_id, class_name: "LigacaoAguaPerfil"
  end
  