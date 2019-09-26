class ImovelPerfil < ActiveRecord::Base
    include IncrementableId
    include API::Filterable
    include API::Model
  
    self.table_name  = 'cadastro.imovel_perfil'
  
    self.primary_key = 'iper_id'
  
    alias_attribute "id", "iper_id"
    alias_attribute "descricao", "iper_dsimovelperfil"
    alias_attribute "indicador_uso", "iper_icuso"
    alias_attribute "ultima_alteracao", "iper_tmultimaalteracao"
    alias_attribute "indicador_geracao_automatica", "iper_icgeracaoautomatica"
    alias_attribute "indicador_gerar_dados_leitura", "iper_icgerardadosleitura"
    alias_attribute "indicador_bloquear_retificacao", "iper_icbloquearetificacao"
    alias_attribute "indicadorInserirManterPerfil", "iper_icinserirmanterperfil"
    alias_attribute "indicadorGrandeConsumidor", "iper_icgrandeconsumidor"
    alias_attribute "indicadorBloqueaDadosSocial", "iper_icbloqueadadossocial"
    alias_attribute "indicadorGeraDebitoSegundaViaConta", "iper_icgerardeb2aviaconta"
    alias_attribute "subcategoria", "scat_id"
    
  end