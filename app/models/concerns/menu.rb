class Menu
  attr_reader :usuario_id
  attr_reader :descricao
  attr_accessor :submenu
  attr_accessor :url

  def initialize(descricao, url = "")
    @descricao = descricao
    @url = url
    @submenu = []
  end
end