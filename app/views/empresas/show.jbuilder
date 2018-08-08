json.entidade do
  json.extract! @empresa, :id, :nome, :email, :ativo, :ultima_alteracao, :principal, :cobranca,
                       :leitura, :encerramento_contrato, :meses_pagamento, :validar_pagamento
end
