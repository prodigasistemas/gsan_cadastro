class Menu
  attr_reader :usuario_id
  attr_reader :descricao
  attr_accessor :submenu
  attr_accessor :url

  def initialize(usuario_id) 
    @usuario_id = usuario_id
    @submenu = []
  end

  def constroi_arvore
    categoria_root
    preenche_menu(@categoria, @funcionalidades)    
  end

  def preenche_menu (categoria, funcionalidades)
    funcionalidades.each do |funcionalidade|
      if funcionalidade.funcionalidade_categoria.id == categoria.id
        funcionalidades.delete funcionalidade
        acao = Menu.new funcionalidade.descricao
        self.submenu << acao
      end if funcionalidade.funcionalidade_categoria
    end 

    categoria.subitens.each do |item|
      submenu = Menu.new(item.descricao)
      self.submenu << submenu
      submenu.preenche_menu(item, funcionalidades)
    end
  end

  private

  def categoria_root
    grupos = UsuarioGrupo.where(usuario_id: @usuario_id)

    @funcionalidades = []

    grupos.each do |grupo|
      @funcionalidades.concat Funcionalidade.funcionalidades_grupo(grupo.grup_id)
    end

    @categoria = FuncionalidadeCategoria.find_by(superior: nil)
  end
end