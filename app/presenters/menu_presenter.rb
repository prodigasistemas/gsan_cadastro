class MenuPresenter
  attr_reader :menu, :usuario_id, :funcionalidades, :categoria

  def initialize(usuario_id)
    @usuario_id = usuario_id
    @menu = Menu.new("Root")
    @count = 0
  end

  def constroi_arvore
    categoria_root

    preenche_menu(menu, @categoria, @funcionalidades.to_a)
  end

  def preenche_menu (item_menu, categoria, funcionalidades)
    funcionalidades.each do |funcionalidade|
      if funcionalidade.funcionalidade_categoria_id == categoria.id
        funcionalidades.delete funcionalidade
        acao = Menu.new(funcionalidade.descricao, funcionalidade.caminho)
        item_menu.submenu << acao
        item_menu.url = ""
        item_menu.id = @count += 1
      end
    end

    categoria.subitens.each do |item|
      submenu = Menu.new(item.descricao)
      item_menu.submenu << submenu
      item_menu.id = @count += 1
      preenche_menu(submenu, item, funcionalidades)
    end

    menu
  end

  private

  def categoria_root
    grupos = UsuarioGrupo.where(usuario_id: @usuario_id)

    @funcionalidades = Funcionalidade.funcionalidades_grupo(grupos.map(&:grup_id))

    @categoria = FuncionalidadeCategoria.includes(subitens: [subitens: [subitens: [:subitens]]]).find_by(superior: nil)
  end

end