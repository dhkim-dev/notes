require "sorbet-runtime"
require "set"

# typed: true
extend T::Sig

"""
T.let(val), <T>)

Local variable declaration and initialization.
The val is required. This is not Java. You don't have default values.
"""
var = T.let(3, Integer)

"""
untyped

Sorbet will NOT do any type checking on values of type T.untyped.
It's possible to use T.untyped as a type explicitly but generally not recommended, as the whole point of Sorbet is to strengthen static type guarantees. 
"""
var_can_be_anything = T.let(1, T.untyped)
var_can_be_anything = 1.0
var_can_be_anything = nil
var_can_be_anything = []
var_can_be_anything = {}

"""
Nil
"""
var = T.let(nil, NilClass)

"""
Nilable

A variable can be either nil or some other <T>
"""
var = T.let(nil, T.nilable(String))
var = T.let("Hello, world", T.nilable(String))

"""
Union Type

T.any(*<T>)

For example, T.any(Integer, String) describes a type whose values can be either Integer or String values, but no others.

Note: T.nilable(String) is equivalent to T.any(nil, String)
"""
var = T.let(3, T.any(Integer, String))
var = "3"

"""
Numeric
"""
var = T.let(10, Integer)
var = T.let(10.0, Float)

"""
Boolean
"""
var = T.let(false, T::Boolean)

"""
String
"""
var = T.let("Hello, world", String)

"""
Symbols
"""
var = T.let(:yogi, Symbol)

"""
Arrays (generics)
"""
var = T.let(["Korean","French","English"], T::Array[String])

"""
Sets (generics)
"""
var = T.let(Set["Charles", "Keith"], T::Set[String])

"""
Hashes (generics)
"""
var = T.let({Charles: 10, Keith: 20}, T::Hash[String, Integer])

"""
User Defined Classes
"""
class Animal
end

class Dog < Animal
end

animal = T.let(Dog.new, Animal)

"""
User Defined Modules
"""
module Flyable
end

class Duck
  include Flyable
end

flyable = T.let(Duck.new, Flyable)

"""
Structs
"""
class Person < T::Struct
  const :name, String, default: "Default Name" # imagine you couldn't change your name...
  prop :age, Integer
end

var = T.let(Person.new(name: "Charles", age: 30), Person)