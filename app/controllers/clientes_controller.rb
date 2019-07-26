class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :update]

  def index
    if params[:query]
      query = params[:query]
      @clientes = Cliente.com_dados.filter(query)
      @total = @clientes.size
      @clientes = @clientes.page(params[:page]).per(20)
    else
      @total = Cliente.count
      @clientes = Cliente.com_dados.page(params[:page]).per(20)
    end
  end

  def show

  end

  def create
    @cliente = Cliente.new cliente_params

    if @cliente.save
      render json: {}, status: :ok
    else
      render json: { errors: @cliente.errors.full_messages }, status: 422
    end
  end

  def update
    if @cliente.update cliente_params
      render json: {}, status: :ok
    else
      render json: { errors: @cliente.errors.full_messages }, status: 422
    end
  end

private

  def set_cliente
    @cliente = Cliente.com_dados.find(params[:id])
  end

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
                                    :negativacao_periodo,
                                    enderecos_attributes: [:id,
                                                            :endereco_tipo_id,
                                                            :logradouro_id,
                                                            :logradouro_bairro_id,
                                                            :logradouro_cep_id,
                                                            :perimetro_inicial_id,
                                                            :perimetro_final_id,
                                                            :referencia_id,
                                                            :numero,
                                                            :complemento,
                                                            :correspondencia,
                                                            :_destroy
                                                          ],
                                    telefones_attributes: [:id,
                                                            :fone_tipo_id,
                                                            :ddd,
                                                            :numero,
                                                            :ramal,
                                                            :padrao,
                                                            :nome_contato,
                                                            :_destroy]
                                    )
  end
end
