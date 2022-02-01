# typed: true
require "byebug"
require "shopify/adt"
require "sorbet-runtime"
extend T::Sig
byebug
'''
Only methods with the word value in them, such as 

{#ok_value}, {#error_value}, {#ok_value_or} 

will

unwrap the result object and return an actual value instead of the Result object
'''

'''
Shopify::Adt::Result.ok
'''
res = Shopify::Adt::Result.ok(0) # Shopify::Adt::ResultWrapper
res.ok? # true
res.error? # false
res.ok_value # true
res.error_value # Shopify::Adt::Result::UncheckedError

'''
Shopify::Adt::Result.error
'''
res = Shopify::Adt::Result.error(1) # Shopify::Adt::ResultWrapper
res.error? # true
res.ok? # false
res.error_value # 1
res.ok_value # Shopify::Adt::Result::UncheckedError

'''
ok_value_or

The ok value if result is Ok, otherwise the fallback_value (the or value)
Provides graceful defaulting on errors.
'''
res = Shopify::Adt::Result.ok(0) # res = Shopify::Adt::Result.ok(0)
res.ok_value_or(1) # 0

res = Shopify::Adt::Result.error(1) # res = Shopify::Adt::Result.ok(0)
res.ok_value_or(0) # 0

'''
ok_value_or_else w/ an ok
  errors block is ignored
  return value is the ok value

ok_value_or_else w/ an error
  error value is passed to the |errors| block (can handle error value inside the block)
  return value is the block return value
  empty return will return nil

Provides defaulting on errors.
#ok_value_or_else is also useful for returning early or raising on errors.  
'''

res = Shopify::Adt::Result.error("bad")
res_ = res.ok_value_or_else do |errors|
  # this block gets called
  p errors
  "fallback return val"
end
# "fallback return val"

res = Shopify::Adt::Result.ok("good")
res_ = res.ok_value_or_else do |errors|
  # this block does not get called
  p errors
  "fallback return val"
end
# "good"


'''
Methods below will not unwrap the result object
'''

'''
map

An ok type result with an updated value if called on Ok, otherwise the original Error.
An ok result with an updated value if called on Ok, otherwise the original Error.
'''
res = Shopify::Adt::Result.ok("Good")
res.map { |price| "#{price} $" } # Shopify::Adt::Result.ok("Good $")

res = Shopify::Adt::Result.error("Bad")
res.map { |price| "#{price} $" } # Shopify::Adt::Result.error("Bad")

'''
or_else

Returns self if Ok, or the return value of the block.
The return value of the block must be a wrapper object.

The value may be of a different Result type
'''

res = Shopify::Adt::Result.error("bad")
res_ = res.or_else do |errors|
  # block gets called
  p "#{errors}!!!!!"
  Shopify::Adt::Result.ok("good") # return val
end

res = Shopify::Adt::Result.ok("good")
res_ = res.or_else do |errors|
  # block doesn't get called
  p "#{errors}!!!!!"
  Shopify::Adt::Result.ok("I think this will be good")
end
# Shopify::Adt::Result.ok("good")

'''
and_then

Returns value of the block if ok, else self
The return value of the block must be a wrapper object.

The value may be of a different Result type
'''

res = Shopify::Adt::Result.ok("good")
res_ = res.and_then do |val|
  p "#{val}"
  Shopify::Adt::Result.ok("val") # return val
end


res = Shopify::Adt::Result.ok("bad")
res_ = res.and_then do |val|
  # block doesn't get called
  p "#{val}"
  Shopify::Adt::Result.ok("val") # return val
end
# Shopify::Adt::Result.ok("bad")

# The caller is expected to handle both the successful and error cases. This can be done by
# first calling {#ok?} or {#error?}, then use {#ok_value} or {#error_value} in the appropriate
# conditional branch to get the wrapped value.
#
#     result = create_product(input)
#     if result.ok?
#       product_id = result.ok_value
#       # ...
#     else
#       errors = result.error_value
#       # ...
#     end
#
# Alternatively, {#or_else} and {#and_then} methods are provided to chain operations that return
# a result object.