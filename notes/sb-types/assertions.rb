# typed: true
extend T::Sig

"""
Type assertions w/ local variables
"""

"""
Nil
"""
var = T.let(nil, NilClass)

"""
Nilable
"""

"""
Numbers
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