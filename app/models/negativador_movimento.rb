class NegativadorMovimento < ActiveRecord::Base
    self.table_name  = 'cobranca.negativador_movimento'
    self.primary_key = 'ngmv_id'
  
    alias_attribute "id",                       "ngmv_id"
    alias_attribute "dataProcessamentoEnvio",   "ngmv_dtprocessamentoenvio"
    alias_attribute "indicadorAceito",          "nmrg_icaceito"
    alias_attribute "codigoExclusaoTipo",       "nmrg_cdexclusaotipo"
    alias_attribute "ngcm_id",                  "ngcm_id"
    alias_attribute "negt_id",                  "negt_id"
    

    belongs_to :negativacao_comando,   foreign_key: :ngcm_id
    belongs_to :negativador,           foreign_key: :negt_id
end

# select clie.clie_nmcliente as nomeCliente, 
#     case when nmrg.nmrg_cdexclusaotipo is not null then 
#         case when ngim_dtexclusao - ngmv_dtprocessamentoenvio > ngcn_nnprazoinclusao then 1 
#         else 2
#         end
#     else case when to_date(sysdate) - ngmv_dtprocessamentoenvio > ngcn_nnprazoinclusao then 1 
#         else 2
#         end
#     end as indicadorNegativacaoConfirmada, 
#     count(*) as qtdeInclusoes
# from  cobranca.negatd_movimento_reg  nmrg
# inner join cobranca.negativador_movimento  ngmv on ngmv.ngmv_id=nmrg.ngmv_id
# inner join cobranca.negativacao_imoveis ngim on ngim.ngcm_id=ngmv.ngcm_id  and ngim.imov_id=nmrg.imov_id
# inner join cobranca.negativador_contrato ngcn on ngcn.negt_id=ngmv.negt_id  and (ngcn_dtcontratoencerramento is null or ngcn_dtcontratofim >= to_date(sysdate))
# inner join cobranca.negativador negt on negt.negt_id=ngmv.negt_id 
# inner join cadastro.cliente clie on clie.clie_id=negt.clie_id where  nmrg.imov_id= :idImovel  and nmrg.nmrg_icaceito= :indicadorAceito and nmrg_idreginclusao is null
# group by clie.clie_nmcliente, 
#     case when nmrg.nmrg_cdexclusaotipo is not null then 
#         case when ngim_dtexclusao - ngmv_dtprocessamentoenvio > ngcn_nnprazoinclusao
#             then 1 else 2 
#         end 
#         else case when to_date(sysdate) - ngmv_dtprocessamentoenvio > ngcn_nnprazoinclusao then 1 
#             else 2 
#         end
#     end order by 1,2; 



#  nmrg_idreginclusao is null quando header and trailler
