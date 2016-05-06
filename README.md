# GSAN Cadastro

Parte servidor/api dos cadastros do GSAN

### Instalar o gerenciador de versões Ruby (http://rvm.io)
    curl -sSL https://get.rvm.io | bash -s stable
    
### Usar a versão 2 do Ruby
    rvm install 2.3.0

### Fazer o clone do projeto
    git clone git@github.com:prodigasistemas/gsan_cadastro.git

### Acessar o projeto
    cd gsan_cadastro

### Instalar as dependências do projeto
    bundle install

## Ambiente de Desenvolvimento

### Executar o gsan_cadastro no localhost:3001
    rails server -p 3001

## Ambiente de Teste

### Gerar usuário e senha
    echo "DB_TEST_USER=usuario" >> .env
    echo "DB_TEST_PASSWORD=senha" >> .env

### Executar a bateria de testes
    rake spec:coverage
