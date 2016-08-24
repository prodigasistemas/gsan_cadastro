class MenuPresenter
  attr_reader :menu, :usuario_id, :funcionalidades, :categoria

  def initialize(usuario_id) 
    @usuario_id = usuario_id
    @menu = Menu.new("Root")
  end

  def constroi_arvore
    categoria_root
    return preenche_menu(menu, @categoria, @funcionalidades)    
  end

  def preenche_menu (item_menu, categoria, funcionalidades)
    funcionalidades.each do |funcionalidade|
      if funcionalidade.funcionalidade_categoria.id == categoria.id
        funcionalidades.delete funcionalidade
        acao = Menu.new(funcionalidade.descricao, "url")
        item_menu.submenu << acao
        item_menu.url = ""
        item_menu.id = funcionalidade.id
      end if funcionalidade.funcionalidade_categoria
    end 

    categoria.subitens.each do |item|
      submenu = Menu.new(item.descricao)
      item_menu.submenu << submenu
      preenche_menu(submenu, item, funcionalidades)
    end

    menu
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