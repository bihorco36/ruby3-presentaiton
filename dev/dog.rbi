class Dog
  attr_reader id: untyped

  attr_reader name: untyped

  attr_reader age: untyped

  attr_reader owner: untyped

  def initialize: (id: untyped, name: untyped, age: untyped) -> void

  def adopt: (owner: untyped) -> untyped
end
