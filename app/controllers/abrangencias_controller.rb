class AbrangenciasController < ApplicationController
  def index
    @abrangencias = Abrangencia.buscar params.require(:query).permit! if params[:query].present?
    @abrangencias ||= Abrangencia.all

    if @abrangencias.any?
      render json: { entidades: @abrangencias.map(&:atributos) }, status: :ok
    else
      render json: { entidades: [] }, status: :ok
    end
  end

  def create
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])

    query = Imovel.check_params(params[:query])

    #corrgir filtros
    # imoveis = Imovel.select(:id).com_dados.where(query.symbolize_keys)
    imoveis = Imovel.select(:id).where(query.symbolize_keys)

    abrangencia_attrs = []
    ultimoId = Abrangencia.maximum(:id)
    ultimoId = 0 if ultimoId.nil?

    imoveis.each do |imovel|
      ultimoId += 1
      
      conta = Conta.do_imovel_com_referencia(imovel.id, @contrato_medicao.referencia_assinatura)
      
      abrangencia_attrs << {
        cmab_id: ultimoId, 
        cmed_id:  @contrato_medicao.id, 
        imov_id: imovel.id,
        last_id: conta.ligacao_agua_situacao_id,
        cmab_tmcriacao: Time.zone.now,
        cmab_tmultimaalteracao: Time.zone.now
      }
    end
    
    Abrangencia.bulk_insert(set_size: abrangencia_attrs.size, values: abrangencia_attrs)
    
    if @contrato_medicao.imoveis.count >= abrangencia_attrs.size
      render json: { entidade: @contrato_medicao.atributos }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def redefinir
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    @contrato_medicao.imoveis = []

    if @contrato_medicao.save
      render json: { entidade: @contrato_medicao.atributos }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @abrangencia = Abrangencia.find params[:id]
    if @abrangencia.destroy
      render json: { }, status: :ok
    else
      render json: { errors: @abrangencia.errors }, status: :unprocessable_entity
    end
  end

  protected

  def abrangencia_params
    params.permit([:contrato_medicao_id, query: [ :id, :localidade_id, :setor_comercial_id, :qdra_id]])
  end
end