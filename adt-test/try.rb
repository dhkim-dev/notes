require "shopify/adt"
require "byebug"

# byebug

res = Shopify::Adt::Result.error("bad")
res_ = res.and_then do |errors|
  p "1"
  p "#{errors}!!!!!"
  p "2"
  Shopify::Adt::Result.ok("SKRRTT") # return val
end
# byebug
p res_
# Shopify::Adt::Result.ok("good")
# byebug

   #     result = CreateProductInput.try_new(input_hash).and_then do |input|
      #       CreateProduct.perform(input)
      #     end