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
    funcionalidades_incluidas = []

    funcionalidades.each do |funcionalidade|
      if categoria.funcionalidades.include? funcionalidade
        funcionalidades_incluidas << funcionalidade
        acao = Menu.new(funcionalidade.descricao, funcionalidade.caminho)
        item_menu.submenu << acao
        item_menu.url = ""
        item_menu.id = @count += 1
      end
    end

    funcionalidades.delete funcionalidades_incluidas

    categoria.subitens.each do |item|
      if categoria_acessivel? item
        submenu = Menu.new(item.descricao)
        item_menu.submenu << submenu
        item_menu.id = @count += 1
        preenche_menu(submenu, item, funcionalidades)
      end
    end

    menu
  end

  private

  def categoria_acessivel? categoria
    @categorias_acessiveis.each do |categoria_acessivel|
      ids_acessiveis = categoria_acessivel.categorias_superiores.map(&:id)
      ids_acessiveis << categoria_acessivel.id

      return true if ids_acessiveis.include? categoria.id
    end

    false
  end

  def categoria_root
    grupos = UsuarioGrupo.where(usuario_id: @usuario_id)

    @funcionalidades = Funcionalidade.funcionalidades_grupo(grupos.map(&:grup_id))
    @categorias_acessiveis = FuncionalidadeCategoria.para_as_funcionalidades(@funcionalidades.map(&:id))
    @categoria = FuncionalidadeCategoria.includes(subitens: [subitens: [subitens: [:subitens]]]).find_by(superior: nil)
  end

end