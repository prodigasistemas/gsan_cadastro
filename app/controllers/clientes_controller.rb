class ClientesController < ApplicationController
  def index
    if params[:query]
      query = params[:query].deep_symbolize_keys
      @clientes = Cliente.filter(query)
      @total = @clientes.size
      @clientes = @clientes.page(params[:page]).per(20)
    else
      @clientes = Cliente.join.page(params[:page]).per(20)
    end
  end

  def create
    @cliente = Cliente.new cliente_params

    if @cliente.save
      render json: {}, status: :ok
    else
      render json: { errors: @cliente.errors.full_messages }, status: 422
    end
  end

  private

  def cliente_params
    params.require(:cliente).permit(:orgao_emissor_rg_id,
                                    :orgao_emissor_uf_id,
                                    :cliente_responsavel_superior_id,
                                    :ramo_atividade_id,
                                    :profissao_id,
                                    :pessoa_sexo_id,
                                    :cliente_tipo_id,
                                    :nome,
                                    :nome_abreviado,
                                    :cpf,
                                    :rg,
                                    :data_emissao_rg,
                                    :nascimento,
                                    :cnpj,
                                    :email,
                                    :ativo,
                                    :acao_cobranca,
                                    :nome_mae,
                                    :cobranca_acrescimos,
                                    :arquivo_texto,
                                    :vencimento_mes_seguinte,
                                    :gera_fatura_antecipada,
                                    :nome_fantasia_conta,
                                    :permite_negativacao,
                                    :negativacao_periodo)
  end
end
