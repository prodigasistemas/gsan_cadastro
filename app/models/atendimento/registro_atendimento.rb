class Atendimento::RegistroAtendimento < Imovel
  def registros_atendimentos
    cadastro = {}

    cadastro[:registros_atendimentos] = get_registros_atendimentos

    cadastro
  end

  private

  def get_registros_atendimentos
    registros_atendimentos = []

    registros_atendimento.map do |ra|
      r = {}
      r[:id] = ra.id
      if ra.situacao_tipo_especificacao.present?
        r[:especificacao] = ra.situacao_tipo_especificacao.descricao
      end
      r[:data_atendimento] = ra.data_hora_registro_atendimento
      r[:data_encerramento] = ra.data_hora_encerramento
      r[:data_encerramento] = ra.data_hora_encerramento
      r[:situacao] = ra.codigo_situacao == 1 ? 'PENDENTE' : 'ENCERRADO'
      if ra.motivo_encerramento.present?
        r[:motivo_encerramento] = ra.motivo_encerramento.descricao
      end
      if ra.registro_atendimento_solicitante.present?
        r[:protocolo] = ra.registro_atendimento_solicitante.numero_protocolo
      end
      registros_atendimentos << r
    end

    registros_atendimentos
  end
end
