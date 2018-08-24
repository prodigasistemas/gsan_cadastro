class ColunaAtualizacaoCadastralJob
  include SuckerPunch::Job
  workers 4

  def perform(imovel_ids, situacao_cadastral_id)
    ImovelControleAtualizacaoCadastral.transaction do
      imovel_controle_atualizacao_cadastrais = ImovelControleAtualizacaoCadastral.where(imov_id: imovel_ids).podem_ser_pre_aprovados
      imovel_atualizacao_cadastrais = ImovelAtualizacaoCadastral.where(imov_id: imovel_ids).podem_ser_pre_aprovados
      imovel_controle_atualizacao_cadastrais.podem_ser_pre_aprovados_em_lote.each do |ic|
        ImovelControleAtualizacaoCadastral.atualizar_valores_colunas(situacao_cadastral_id,
                                                                     ic.imovel_id,
                                                                     ic.situacao_atualizacao_cadastral_id)
      end
      imovel_controle_atualizacao_cadastrais.update_all(siac_id: situacao_cadastral_id, icac_tmpreaprovacao: Time.current)
      imovel_atualizacao_cadastrais.update_all(siac_id: situacao_cadastral_id)
    end
  end

end
