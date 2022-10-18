class Badger
  attr_reader :brand

  def initialize(brand = "Honeybadger")
    @brand = brand
  end

  def brand?
    @brand
  end
end
