class Dog
  attr_reader :id
  attr_reader :name, :age, :owner

  def initialize (id: , name: , age: )
    @id = id
    @name = name
    @age = age
  end

  def adopt(owner: )
    @owner = owner
  end

end
