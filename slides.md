---
theme: seriph
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Ruby >= 3
  What is new

drawings:
  persist: false
css: unocss
title: Ruby >= 3
---

# Ruby >= 3

Features, Improvements and Changes of Ruby 3.0 and higher

---

# Overview

<br>

- Performance
- Parallel Computing (Ractor)
- Type Checking
- Pattern Matching
- Debugger
- Small but neat stuff
- Ruby 3.2 Preview

---

# Performance

<img v-click src="https://www.fastruby.io/blog/assets/images/RRBPerfHistory_720.png" class="m-25 h-60 rounded shadow" />
---

<h1>YJIT - Yet another Ruby JIT <a style="font-size:14px;" href="https://github.com/Shopify/yjit">[1]</a></h1>

<img v-click src="https://cdn.shopify.com/s/files/1/0779/4361/files/YJITBarGraph_3d4b6747-fb61-48e0-ac48-67008b3deac3.png?format=webp&v=1634233279" class="m-21 h-80" title="Benchmark speed (iterations/second) scaled to the interpreter’s performance (higher is better)"/>

---

# Ractor
<br>

Ractor is an Actor-model abstraction for Ruby that provides thread-safe parallel execution.<a href="https://ruby-doc.org/core-3.1.0/Ractor.html">[1]</a>

---

# Ractor

```rb
a = 1
r = Ractor.new do
  a_in_ractor = receive # receive blocks till somebody will pass message
  puts "I am in Ractor! a=#{a_in_ractor}"
end
r.send(a)  # pass it
r.take
# here "I am in Ractor! a=1" would be printed
```
---

# Ractor

```rb{1-16|19-22}
def tarai(x, y, z) =
  x <= y ? y : tarai(tarai(x-1, y, z),
                     tarai(y-1, z, x),
                     tarai(z-1, x, y))
require 'benchmark'
Benchmark.bm do |x|
  # sequential version
  x.report('seq'){ 4.times{ tarai(14, 7, 0) } }
 
  # parallel version with ractors
  x.report('par'){
    4.times.map do
      Ractor.new { tarai(14, 7, 0) }
    end.each(&:take)
  }
end


Benchmark result:
          user     system      total        real
seq  64.560736   0.001101  64.561837 ( 64.562194)
par  66.422010   0.015999  66.438009 ( 16.685797)
```

---

<h1>Type Checking with RBS <a style="font-size:14px;" href="https://github.com/ruby/rbs">[1]</a></h1>

<img src="/rbs.jpg" class="m-10 h-95 rounded shadow" />

---

<h1>Type Checking with RBS <a style="font-size:14px;" href="https://github.com/ruby/rbs">[1]</a></h1>

```rb
class Badger
    def initialize(brand)
      @brand = brand
    end

    def brand?
      @brand
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
```

---
layout: center
---

<h1>Pattern Matching <a style="font-size:14px;" href="https://blog.saeloun.com/2021/07/07/ruby-3-1-pattern-matching-pin-operator.html">[1]</a></h1>

<Tweet id="1475447573376737280" />

---

<h1>Pattern Matching <a style="font-size:14px;" href="https://blog.saeloun.com/2021/07/07/ruby-3-1-pattern-matching-pin-operator.html">[1]</a></h1>

```rb
case [1, 2, "Three"]
in [Integer, Integer, String]
  "matches"
in [1, 2, "Three"]
  "matches"
in [Integer, *]
  "matches" # because * is a spread operator that matches anything
in [a, *]
  "matches" # and the value of the variable a is now 1
end
```
<p style="font-size:8px;">note that only the first in will be evaluated, as case stops looking after the first match</p>
---

# Pattern Matching - Pin Operator

```rb
case "Do you like cats?"
in ^(/like/)
  puts "Match"
end

#=> Match
```
---

# Pattern Matching - Pin Operator
```rb{1-13|14-20|22|all}
data = { "name": "Alice",
         "age": 30,
         "children": [
            {
              "name": "Bob",
              "age": 6
            },
            {
              "name": "Jilly",
              "age": 4
            }
          ]
        }

case data
in name: "Alice", children: [*, { name: child_name, age: ^(1..4) }]
  "matched: #{child_name}"
else
  "not matched"
end

#=> matched: Jilly
```

---

# Debugger

```rb
3.1.1 :001 >






```

---

# Small but neat


```rb {1-4|8-11}
# Endless Method definition
def increment(x) = x + 1

p increment(41) #=> 42



# Except method in Hash
user = { name: 'Janiss', age: 25, role: 'developer' }

user.except(:role) #=> {:name=> "Janiss", :age=> 25}
```
---

# Shorthand hash syntax
```rb {1-5|1,2,7,8|11-16|11-13,18,19|all}
a = 1
b = 2

# Old
{ a: a, b: b } #=> { a: 1, b: 2}

# Ruby 3.1
{ a:, b: } #=> { a: 1, b: 2 }


##################
# keyword arguments
###################

# Old
foo(a: a, b: b)

# 3.1
foo(a:, b:)
```

---

<h1>Ruby 3.2 preview <a style="font-size:14px;" href="https://www.ruby-lang.org/en/news/2022/04/03/ruby-3-2-0-preview1-released/">[1]</a></h1>

- WASI based WebAssembly support
- Find pattern is no longer experimental
- Regexp timeout
- Data.define

---

<h1>Regexp timeout - Ruby 3.2 <a style="font-size:14px;" href="https://www.ruby-lang.org/en/news/2022/04/03/ruby-3-2-0-preview1-released/">[1]</a></h1>

```rb{1|3,4|6}
Regexp.timeout = 1.0 # 1 second

/^a*b?a*$/ =~ "a" * 50000 + "x"
#=> Regexp::TimeoutError is raised in one second

long_time_re = Regexp.new("^a*b?a*$", timeout: nil)
```

---

<h1>Data.define - Ruby 3.2 <a style="font-size:14px;" href="https://dev.to/baweaver/new-in-ruby-32-datadefine-2819">[1]</a></h1>

```rb{1-3|5-8|10-15}
Point = Data.define(:x, :y)
origin = Point.new(0, 0)
north_of_origin = Point.new(x: 0, y: 10)

# Also Takes a block
Point = Data.define(:x, :y) do
  def +(other) = new(self.x + other.x, self.y + other.y)
end

case origin
in Point[x: 0 => x, y] # rightward assignment, pattern matching
  Point.new(x:, y: y + 5) # shorthand hash syntax
else
  origin
end
```
