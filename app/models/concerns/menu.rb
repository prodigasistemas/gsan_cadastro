class Menu
  attr_reader :descricao
  attr_accessor :submenu, :url, :id

  def initialize(descricao, url = "")
    @descricao = descricao
    @url = url
    @submenu = []
  end
end