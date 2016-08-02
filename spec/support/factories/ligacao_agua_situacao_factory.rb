FactoryGirl.define do
  factory :ligacao_agua_situacao do
    descricao "Teste"
    indicador_uso 1
    ultima_alteracao Time.zone.now

    # not-null constraint
    last_icfaturamento 1
    last_nnconsumominimo 1
  end
end