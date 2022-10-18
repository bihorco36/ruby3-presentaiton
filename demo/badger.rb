class Badger

    attr_reader :brand

    def initialize(brand)
      @brand = brand
    end

end

class Honey < Badger

  def initialize(brand: "Honeybadger", sweet: true)
    super(brand)
    @sweet = sweet
  end

  def sweet?
    @sweet
  end

end
